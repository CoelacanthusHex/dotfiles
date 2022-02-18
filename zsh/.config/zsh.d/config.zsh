unsetopt nomatch
# https://blog.lilydjwg.me/2015/7/26/a-simple-zsh-module.116403.html
# https://gist.github.com/lilydjwg/0bfa6807b88e6d39a995
zmodload zsh/subreap 2>/dev/null && subreap
autoload -Uz is-at-least
# 选项设置
unsetopt beep
# 自动记住已访问目录栈
setopt auto_pushd
DIRSTACKSIZE=128
setopt pushd_ignore_dups
setopt pushd_minus
# 不需要打 cd，直接进入目录
setopt autocd
# 以附加的方式写入历史纪录
setopt append_history
# 不保存重复的历史记录项
setopt hist_save_no_dups
setopt hist_ignore_dups
# 在命令前添加空格，不将此命令添加到记录文件中
setopt hist_ignore_space
# zsh 4.3.6 doesn't have this option, better perf
setopt hist_fcntl_lock 2>/dev/null
if is-at-least 5.0.5; then
    # This may cause the command messed up due to a memcpy bug
else
    setopt hist_reduce_blanks
fi
# 为历史纪录中的命令添加时间戳
setopt extended_history
# 展开历史时不执行
setopt hist_verify
# 实例之间即时共享历史
# setopt share_history
# 使用 fc -IR 读取历史  fc -IA 保存历史
# 允许在交互模式中使用注释  例如：
#cmd #这是注释
setopt interactive_comments
# setopt 的输出显示选项的开关状态
setopt ksh_option_print
# disown 后自动继续进程
setopt auto_continue
# 启用增强 glob
setopt extended_glob
# using c format hexadecimal number
setopt c_bases
# disable for problems with parsing of, for example, date and time strings with leading zeroes
unsetopt octal_zeroes
# RPROMPT 执行完命令后就消除, 便于复制
setopt transient_rprompt
# prompt more dynamic, allow function in prompt
setopt prompt_subst
# 单引号中的 '' 表示一个 ' （如同 Vimscript 中者）
setopt rc_quotes

# Disable tty flow control, allows vim to use '<Ctrl>S'
unsetopt flow_control && stty -ixon

# set tab size
tabs -4

# Others
autoload -Uz zmv
autoload -Uz zargs

bindkey -e
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# set end of file mark
export PROMPT_EOL_MARK="%B%F{red}🔚"

# Help
unalias run-help 2> /dev/null
autoload -Uz run-help
alias help=run-help

autoload -Uz run-help-git
autoload -Uz run-help-ip
autoload -Uz run-help-openssl
autoload -Uz run-help-p4
autoload -Uz run-help-sudo
autoload -Uz run-help-svk
autoload -Uz run-help-svn

# Terminal Title
autoload -Uz add-zsh-hook

function set-xterm-terminal-title () {
    printf '\e]2;%s\a' "$@"
}

case ${TERM} in
    xterm*|rxvt*|Eterm|aterm|kterm|gnome*|konsole*)
        function precmd-set-terminal-title () {
            #set-xterm-terminal-title "${(%):-"%n@%m: %~"}"
            printf "\e]2;%s@%s: %s\a" "${USER}" "${HOST%%.*}" "${(D)PWD}"
        }
        function preexec-set-terminal-title () {
            #set-xterm-terminal-title "${(%):-"%n@%m: "}$2"
            printf "\e]2;%s@%s: %s\a" "${USER}" "${HOST%%.*}" "$2"
        }
        ;;
    screen*|tmux*)
        function precmd-set-terminal-title () {
            printf "\033_%s@%s: %s\033\\" "${USER}" "${HOST%%.*}" "${(D)PWD}"
        }
        function preexec-set-terminal-title () {
            printf "\033_%s@%s: %s\033\\" "${USER}" "${HOST%%.*}" "$2"
        }
        ;;
    *)
        function precmd-set-terminal-title () {
            set-xterm-terminal-title "${(%):-"%n@%m: %~"}"
        }
        
        function preexec-set-terminal-title () {
            set-xterm-terminal-title "${(%):-"%n@%m: "}$2"
        }
        ;;
esac

add-zsh-hook -Uz precmd precmd-set-terminal-title
add-zsh-hook -Uz preexec preexec-set-terminal-title

if is-at-least 5.1; then
    # https://archive.zhimingwang.org/blog/2015-09-21-zsh-51-and-bracketed-paste.html
    autoload -Uz bracketed-paste-url-magic
    zle -N bracketed-paste bracketed-paste-url-magic
else
    # zsh 5.1+ uses bracketed-paste-url-magic
    autoload -Uz url-quote-magic
    zle -N self-insert url-quote-magic
    toggle-uqm () {
        if zle -l self-insert; then
            zle -A .self-insert self-insert && zle -M "switched to self-insert"
        else
            zle -N self-insert url-quote-magic && zle -M "switched to url-quote-magic"
        fi
    }
    zle -N toggle-uqm
    bindkey '^X$' toggle-uqm
fi

# better than copy-prev-word
bindkey "^[^_" copy-prev-shell-word

autoload -Uz colors && colors

() {
    local white_b=$fg_bold[white] blue=$fg_bold[blue] rst=$reset_color
    local white_b=$'\e[97m' blue=$'\e[94m' rst=$'\e[0m'
    TIMEFMT=("== TIME REPORT FOR $white_b%J$rst =="$'\n'
        "  User: $blue%U$rst"$'\t'"System: $blue%S$rst  Total: $blue%*Es${rst}"$'\n'
        "  CPU:  $blue%P$rst"$'\t'"Mem:    $blue%M MiB$rst")
}

SPROMPT="%B%F{yellow}zsh: correct '%R' be '%r' [nyae]?%f%b "

[[ "$COLORTERM" == (24bit|truecolor) || (( ${terminfo[colors]} == 16777216 )) ]] || zmodload zsh/nearcolor

# Basic LS_COLORS
(( $_in_gui == 1 )) || [[ -n $ANDROID_ROOT ]] || eval "$(dircolors -b)"

# Extended LS_COLORS
eval "$(dircolors -b $ZDOTDIR/plugins/LS_COLORS)"

# https://github.com/lilydjwg/dotzsh/blob/313050449529c84914293283691da1e824d779f5/zshrc#L292
# Esc-Esc 在当前/上一条命令前插入 sudo
function sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    [[ $BUFFER != sudo\ * && $UID -ne 0 ]] && {
        typeset -a bufs
        bufs=(${(z)BUFFER})
        # disable expand aliases after sudo because we have enable aliases after sudo
        #while (( $+aliases[$bufs[1]] )); do
        #    local expanded=(${(z)aliases[$bufs[1]]})
        #    bufs[1,1]=($expanded)
        #    if [[ $bufs[1] == $expanded[1] ]]; then
        #        break
        #    fi
        #done
        bufs=(sudo $bufs)
        BUFFER=$bufs
    }
    zle end-of-line
}
zle -N sudo-command-line
bindkey "\e\e" sudo-command-line

# Enable aliases to be sudo’ed
# http://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
alias sudo='sudo '
alias cgproxy='cgproxy '

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4;
