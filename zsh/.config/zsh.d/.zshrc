## .zshrc

#[ -f $HOME/.bashrc ] && source $HOME/.bashrc

disable_starship=0
disable_pure=1
disable_async_prompt=0

autoload -Uz is-at-least
if (( ! $disable_starship )) && [[ -x /usr/bin/starship ]] && is-at-least 1.2.0 $(starship --version | head -n 1 | cut -d' ' -f2); then
    export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship.toml
    eval "$(starship init zsh)"
elif (( ! $disable_pure )) && [[ -r "/usr/share/zsh/functions/Prompts/prompt_pure_setup" ]]; then
    ## config for pure
    autoload -U promptinit && promptinit
    prompt pure
elif (( ! $disable_async_prompt )) && is-at-least 5.0.6 && (( $+commands[git] )); then # zsh until 5.0.5 has a CPU 100% bug with zle -F
    ## config for async
    # Modify from https://blog.lilydjwg.me/2014/2/19/asynchronously-update-zsh-prompt.42906.html
    
    setopt prompt_subst

    _nogit_dir=()
    for p in $nogit_dir; do
        [[ -d $p ]] && _nogit_dir+=$(realpath $p)
    done
    unset p

    typeset -g _current_branch= vcs_info_fd=
    zmodload zsh/zselect 2>/dev/null

    _vcs_update_info () {
    eval $(read -rE -u$1)
    zle -F $1 && vcs_info_fd=
    exec {1}>&-
    # update prompt only when necessary to avoid double first line
    [[ -n $_current_branch ]] && zle reset-prompt
    }

    _set_current_branch () {
        _current_branch=
        [[ -n $vcs_info_fd ]] && zle -F $vcs_info_fd
        cwd=$(pwd -P)
        for p in $_nogit_dir; do
            if [[ $cwd == $p* ]]; then
                return
            fi
        done

        setopt localoptions no_monitor
        coproc {
            _br=$(git branch --no-color 2>/dev/null)
            if [[ $? -eq 0 ]]; then
                _current_branch=$(echo $_br | awk '$1 == "*" {print "%{\x1b[33m%} ("substr($0, 3) ")"}')
            fi
            # always gives something for reading, or _vcs_update_info won't be
            # called, fd not closed
            #
            # "typeset -p" won't add "-g", so reprinting prompt (e.g. after status
            # of a bg job is printed) would miss it
            #
            # need to substitute single ' with double ''
            print "typeset -g _current_branch='${_current_branch//''''/''}'"
        }
        disown %{\ _br 2>/dev/null
        exec {vcs_info_fd}<&p
        # wait 0.1 seconds before showing up to avoid unnecessary double update
        # precmd functions are called *after* prompt is expanded, and we can't call
        # zle reset-prompt outside zle, so turn to zselect
        zselect -r -t 10 $vcs_info_fd 2>/dev/null
        zle -F $vcs_info_fd _vcs_update_info
    }

    autoload -Uz vcs_info add-zsh-hook
    add-zsh-hook precmd _set_current_branch
    
    PROMPT='%F{green}%n%f @ %F{magenta}%m%f in %B%F{yellow}%~%f%b at$_current_branch%f -> %(?.%F{green}!.%F{red}?->%?)%f
%F{blue}>>>%f '
    RPROMPT="%T"
    PROMPT2="%F{yellow}>>>%f "
else
    ## config for fallback
    autoload -Uz vcs_info add-zsh-hook
    setopt prompt_subst
    add-zsh-hook precmd vcs_info

    zstyle ':vcs_info:*' formats '%F{green}(%s)%f-%F{red}[%b]%f%u%c%F{blue}%m%f'
    zstyle ':vcs_info:*' actionformats '%F{green}(%s)%f-%F{red}[%b|%a]%f%u%c%F{blue}%m%f'
    zstyle ':vcs_info:git*+set-message:*' hooks git-st
    zstyle ':vcs_info:*' enable git hg svn

    PROMPT='%F{green}%n%f @ %F{magenta}%m%f in %B%F{yellow}%~%f%b at $vcs_info_msg_0_ -> %(?.%F{green}!.%F{red}?->%?)%f
%F{blue}>>>%f '
    RPROMPT="%T"
    PROMPT2="%F{yellow}>>>%f "
fi

source $ZDOTDIR/check.zsh
source $ZDOTDIR/config.zsh
source $ZDOTDIR/completion.zsh
source $ZDOTDIR/function.zsh
source $ZDOTDIR/alias.zsh
source $ZDOTDIR/plugin.zsh
source $ZDOTDIR/keybind.zsh

if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    OS=Debian
    VER=$(cat /etc/debian_version)
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi

case $OS in
    Arch*)
        source $ZDOTDIR/Arch.zsh
    ;;
    *)
        : # do nothing now
    ;;

esac


unset OS
unset VER

# Load user config.
if [[ -f $ZDOTDIR/.zshrc.local ]]; then
    source $ZDOTDIR/.zshrc.local
fi

# https://wiki.archlinux.org/index.php/GnuPG#Configure_pinentry_to_use_the_correct_TTY
# it's much faster than the commonly used `export GPG_TTY=$(tty)`
export GPG_TTY=$TTY

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4; syntax zsh;
