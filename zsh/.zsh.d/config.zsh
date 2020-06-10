# check first, or the script will end wherever it fails
zmodload zsh/regex 2>/dev/null && _has_re=1 || _has_re=0
unsetopt nomatch
zmodload zsh/subreap 2>/dev/null && subreap
# 选项设置{{{1
unsetopt beep
# 自动记住已访问目录栈
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_minus
#以附加的方式写入历史纪录
setopt INC_APPEND_HISTORY
#如果连续输入的命令相同，历史纪录中只保留一个
setopt HIST_IGNORE_DUPS
#为历史纪录中的命令添加时间戳
setopt EXTENDED_HISTORY
#允许在交互模式中使用注释  例如：
#cmd #这是注释
setopt INTERACTIVE_COMMENTS
#扩展路径
#/v/c/p/p => /var/cache/pacman/pkg
setopt complete_in_word
# 补全列表不同列可以使用不同的列宽
setopt listpacked
# 补全 identifier=path 形式的参数
setopt magic_equal_subst
# disown 后自动继续进程
setopt auto_continue
setopt extended_glob

# Others
autoload -Uz zmv
autoload -Uz zargs
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

function precmd-set-terminal-title () {
    set-xterm-terminal-title "${(%):-"%n@%m: %~"}"
}

function preexec-set-terminal-title () {
    set-xterm-terminal-title "${(%):-"%n@%m: "}$2"
}

if [[ "$TERM" == (screen*|xterm*|rxvt*|tmux*|putty*|konsole*|gnome*) ]]; then
    add-zsh-hook -Uz precmd precmd-set-terminal-title
    add-zsh-hook -Uz preexec preexec-set-terminal-title
fi


# https://archive.zhimingwang.org/blog/2015-09-21-zsh-51-and-bracketed-paste.html
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic

# zsh 5.1+ uses bracketed-paste-url-magic
if [[ $ZSH_VERSION =~ '^[0-4]\.' || $ZSH_VERSION =~ '^5\.0\.[0-9]' ]]; then
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

autoload -Uz colors zsh/terminfo
colors

() {
  autoload -Uz colors
  colors
  local white_b=$fg_bold[white] blue=$fg_bold[blue] rst=$reset_color
  local white_b=$'\e[97m' blue=$'\e[94m' rst=$'\e[0m'
  TIMEFMT=("== TIME REPORT FOR $white_b%J$rst =="$'\n'
    "  User: $blue%U$rst"$'\t'"System: $blue%S$rst  Total: $blue%*Es${rst}"$'\n'
    "  CPU:  $blue%P$rst"$'\t'"Mem:    $blue%M MiB$rst")
}
