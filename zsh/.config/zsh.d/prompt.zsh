# shellcheck disable=1091

autoload -Uz colors && colors

typeset -A _status_to_signal
_status_to_signal[1]="ERROR"
_status_to_signal[128+1]="HUP"
_status_to_signal[128+2]="INT"
_status_to_signal[128+3]="QUIT"
_status_to_signal[128+4]="ILL"
_status_to_signal[128+5]="TRAP"
_status_to_signal[128+6]="IOT"
_status_to_signal[128+7]="BUS"
_status_to_signal[128+8]="FPE"
_status_to_signal[128+9]="KILL"
_status_to_signal[128+10]="USR1"
_status_to_signal[128+11]="SEGV"
_status_to_signal[128+12]="USR2"
_status_to_signal[128+13]="PIPE"
_status_to_signal[128+14]="ALRM"
_status_to_signal[128+15]="TERM"
_status_to_signal[128+16]="STKFLT"
_status_to_signal[128+17]="CHLD"
_status_to_signal[128+18]="CONT"
_status_to_signal[128+19]="STOP"
_status_to_signal[128+20]="TSTP"
_status_to_signal[128+21]="TTIN"
_status_to_signal[128+22]="TTOU"
_status_to_signal[128+23]="URG"
_status_to_signal[128+24]="XCPU"
_status_to_signal[128+25]="XFSZ"
_status_to_signal[128+26]="VTALRM"
_status_to_signal[128+27]="PROF"
_status_to_signal[128+28]="WINCH"
_status_to_signal[128+29]="IO"
_status_to_signal[128+30]="PWR"
_status_to_signal[128+31]="SYS"

.prompt.set_pipe_status() {
    local _pipestatus=($pipestatus) _status=$status
    if (( $#_pipestatus == 1 )); then
        if (( $_status == 0 )); then
            printf -v _pipe_status "$fg_bold[green]%s$reset_color -> $fg_bold[blue]0x%x$reset_color" ! $_status
        else
            if (( $+_status_to_signal[$_status] )); then
                printf -v _pipe_status "$fg_bold[red]%s$reset_color -> $fg_bold[red]%s$reset_color $fg_bold[blue]0x%x$reset_color" X $_status_to_signal[$_status] $_status
            else
                printf -v _pipe_status "$fg_bold[red]%s$reset_color -> $fg_bold[blue]0x%x$reset_color" X $_status
            fi
        fi
    else
        local _multiple_pipe_status=()
        local _total_pipe_status
        local _single_status
        for _status in $_pipestatus; do
            if (( $_status == 0 )); then
                printf -v _single_status "$fg_bold[green]%s$reset_color -> $fg_bold[blue]0x%x$reset_color" ! $_status
            else
                if (( $+_status_to_signal[$_status] )); then
                    printf -v _single_status "$fg_bold[red]%s$reset_color -> $fg_bold[red]%s$reset_color $fg_bold[blue]0x%x$reset_color" X $_status_to_signal[$_status] $_status
                else
                    printf -v _single_status "$fg_bold[red]%s$reset_color -> $fg_bold[blue]0x%x$reset_color" X $_status
                fi
            fi
            _multiple_pipe_status+=($_single_status)
        done
        if (( $_status == 0 )); then
            printf -v _total_pipe_status "$fg_bold[green]%s$reset_color -> $fg_bold[blue]0x%x$reset_color" ! $_status
        else
            if (( $+_status_to_signal[$_status] )); then
                printf -v _total_pipe_status "$fg_bold[red]%s$reset_color -> $fg_bold[red]%s$reset_color $fg_bold[blue]0x%x$reset_color" X $_status_to_signal[$_status] $_status
            else
                printf -v _total_pipe_status "$fg_bold[red]%s$reset_color -> $fg_bold[blue]0x%x$reset_color" X $_status
            fi
        fi
        _pipe_status="[ ${(j: | :)_multiple_pipe_status} ] => $_total_pipe_status"
    fi
}


autoload -Uz is-at-least
if (( ! $disable_starship )) && [[ -x /usr/bin/starship ]] \
        && is-at-least 1.2.0 $(starship --version | head -n 1 | cut -d' ' -f2); then
    export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship.toml
    eval "$(starship init zsh)"
elif (( ! $disable_async_prompt )) && is-at-least 5.0.6 && (( $+commands[git] )); then # zsh until 5.0.5 has a CPU 100% bug with zle -F
    ## config for async
    # Modify from https://blog.lilydjwg.me/2014/2/19/asynchronously-update-zsh-prompt.42906.html
    
    setopt prompt_subst

    _nogit_dir=()
    for p in $nogit_dir; do
        [[ -d $p ]] && _nogit_dir+=$(realpath $p)
    done
    unset p

    typeset -g _current_branch= _current_status= vcs_info_fd=
    zmodload zsh/zselect 2> /dev/null

    .prompt.vcs_update_info() {
        local fd=$1
        {
            zle -F "$fd" && vcs_info_fd=
            eval $(read -rE -u$fd)
            # update prompt only when necessary to avoid double first line
            [[ -n $_current_branch ]] || [[ -n $_current_status ]] && zle reset-prompt
        } always {
            exec {fd}>&-
        }
    }

    .prompt.set_git_status() {
        _current_branch=
        _current_status=
        [[ -n $vcs_info_fd ]] && zle -F $vcs_info_fd
        cwd=$(pwd -P)
        for p in $_nogit_dir; do
            if [[ $cwd == $p* ]]; then
                return
            fi
        done

        setopt localoptions no_monitor
        local upstream= behind= push= ahead= head=
        coproc {
            head=$(git branch --show-current --no-color 2> /dev/null) && [[ -n $head ]] || head=$(git branch -q --no-color --points-at=@ 2> /dev/null | tr -d '()' | cut -d' ' -f5)
            if (( $status == 0 )); then
                printf -v _current_branch "\x1b[33m (%s)" $head
            fi

            if upstream=$( git rev-parse -q --abbrev-ref @{u} 2> /dev/null ) && [[ -n $upstream ]]; then
                git config --local remote.$upstream:h.fetch '+refs/heads/*:refs/remotes/'$upstream:h'/*' 2> /dev/null

                upstream=${${upstream%/$head}#upstream/}
                behind=${$( git rev-list --count --right-only @...@{u} ):#0}
            fi

            if push=${${"$( git rev-parse -q --abbrev-ref @{push} 2> /dev/null )"%/$head}#origin/} && [[ -n $push ]]; then
                if [[ $push != $upstream ]]; then
                    ahead=${$( git rev-list --count --left-only @...@{push} ):#0}
                else
                    ahead=${$( git rev-list --count --left-only @...@{u} ):#0}
                fi
            fi

            _current_status=""
            if [ -n $ahead ]; then
                _current_status=" %F{green}↑$ahead%f"
            elif [ -n $ahead ]; then
                _current_status="$_current_status %F{red}↓$behind%f"
            fi

            # always gives something for reading, or _vcs_update_info won't be
            # called, fd not closed
            #
            # "typeset -p" won't add "-g", so reprinting prompt (e.g. after status
            # of a bg job is printed) would miss it
            #
            # need to substitute single ' with double ''
            print "typeset -g _current_branch='${_current_branch//''''/''}' _current_status='${_current_status//''''/''}'"
        }
        disown %{\ head 2> /dev/null
        exec {vcs_info_fd}<&p
        # wait 0.1 seconds before showing up to avoid unnecessary double update
        # precmd functions are called *after* prompt is expanded, and we can't call
        # zle reset-prompt outside zle, so turn to zselect
        zselect -r -t 10 $vcs_info_fd 2> /dev/null
        zle -F $vcs_info_fd .prompt.vcs_update_info
    }

    autoload -Uz add-zsh-hook
    add-zsh-hook precmd .prompt.set_pipe_status
    add-zsh-hook precmd .prompt.set_git_status
    
    PROMPT='%F{green}%n%f @ %F{magenta}%m%f in %B%F{yellow}%~%f%b at$_current_branch$_current_status%f -> $_pipe_status%f
%F{blue}>>>%f '
    RPROMPT="%T"
    PROMPT2="%F{yellow}>>>%f "
elif (( ! $disable_pure )) \
        && [[ -r "/usr/share/zsh/functions/Prompts/prompt_pure_setup" ]] \
        || (autoload -U promptinit && promptinit; prompt -l | grep pure); then
    ## config for pure
    autoload -U promptinit && promptinit
    prompt pure
else
    ## config for fallback
    setopt prompt_subst

    autoload -Uz vcs_info add-zsh-hook
    add-zsh-hook precmd vcs_info
    add-zsh-hook precmd .prompt.set_pipe_status

    zstyle ':vcs_info:*' formats '%F{green}(%s)%f-%F{red}[%b]%f%u%c%F{blue}%m%f'
    zstyle ':vcs_info:*' actionformats '%F{green}(%s)%f-%F{red}[%b|%a]%f%u%c%F{blue}%m%f'
    zstyle ':vcs_info:git*+set-message:*' hooks git-st
    zstyle ':vcs_info:*' enable git hg svn

    PROMPT='%F{green}%n%f @ %F{magenta}%m%f in %B%F{yellow}%~%f%b at $vcs_info_msg_0_ -> $_pipe_status%f
%F{blue}>>>%f '
    RPROMPT="%T"
    PROMPT2="%F{yellow}>>>%f "
fi

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4; syntax zsh;
