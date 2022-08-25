# 扩展路径 单词中也进行补全
#/v/c/p/p => /var/cache/pacman/pkg
setopt complete_in_word
# 补全列表不同列可以使用不同的列宽
setopt listpacked
# 补全 identifier=path 形式的参数
setopt magic_equal_subst

zmodload zsh/complist

# using hjkl to select completion menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Load and initialize the completion system ignoring insecure directories with a
# cache time of 20 hours, so it should almost always regenerate the first time a
# shell is opened each day.
autoload -Uz compinit
_comp_files=($ZSH_COMPDUMP(Nmh-20))
if (( $#_comp_files )); then
    compinit -C -d "$ZSH_COMPDUMP"
else
    compinit -d "$ZSH_COMPDUMP"
fi
unset _comp_files

# 禁用旧补全系统
zstyle ':completion:*' use-compctl false
function compctl() {
    print -P "\n%F{red}Don't use compctl anymore%f"
}

# Execute code in the background to not affect the current session
(
    setopt local_options extended_glob
    autoload -U zrecompile
    # Compile zcompdump, if modified, to increase startup speed.
    if [[ -s "$ZSH_COMPDUMP" && (! -s "$ZSH_COMPDUMP.zwc" || "$ZSH_COMPDUMP" -nt "$ZSH_COMPDUMP.zwc") ]]; then
        zrecompile -pq "$ZSH_COMPDUMP"
    fi

    zrecompile -pq $HOME/.zshenv
    zrecompile -pq $ZDOTDIR/.zshrc

    local ZSHCONFIG=$ZDOTDIR
    for f in $ZSHCONFIG/**/*.zsh;
    do
        zrecompile -pq $f;
    done
) &!

autoload -U +X bashcompinit && bashcompinit
#[[ -f /usr/share/bash-completion/bash_completion ]] && source /usr/share/bash-completion/bash_completion
#[[ -f /usr/share/php/arcanist/support/shell/rules/bash-rules.sh ]] && source /usr/share/php/arcanist/support/shell/rules/bash-rules.sh
#(( $+commands[stack] )) && eval "$(stack --bash-completion-script stack)"

# enable hidden files completion
_comp_options+=(globdots)

# Some functions, like _apt and _dpkg, are very slow. We can use a cache in
# order to speed things up
zstyle ':completion:*' use-cache yes
_cache_dir=$ZSH_CACHE_HOME/zcache
zstyle ':completion:*' cache-path $_cache_dir
zstyle ':completion:*:complete:*' cache-policy _c10s_caching_policy
function _c10s_caching_policy() {
    # 缓存策略：若不存在或 14 天以前则认定为失效
    [[ ! -f $1 && -n "$1"(Nm+14) ]]
}
unset _cache_dir

# ignore duplicate entries
zstyle ':completion:*:history-words'   remove-all-dups yes
zstyle ':completion:*:history-words'   stop yes

# define files to ignore for zcompile
zstyle ':completion:*:*:zcompile:*'    ignored-patterns '(*~|*.zwc|*.zwc.old)'
zstyle ':completion:correct:'          prompt 'correct to: %e'

# ignore completion functions for commands you don't have:
zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'

# Enable case-insensitive completion
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**'

# 增强版文件名补全
# 0 - 完全匹配 ( Abc -> Abc )      1 - 大写修正 ( abc -> Abc )
# 2 - 单词补全 ( f-b -> foo-bar )  3 - 后缀补全 ( .cxx -> foo.cxx )
zstyle ':completion:*:(argument-rest|files):*' matcher-list '' \
    'm:{[:lower:]-}={[:upper:]_}' \
    'r:|[.,_-]=* r:|=*' \
    'r:|.=* r:|=*'

# when correcting, original string should be added as a possible completion
zstyle ':completion:*' original true

# 样式
zstyle ':completion:*' menu yes select
# 分组显示
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*:matches' group yes
zstyle ':completion:*:options' description yes
# https://thevaluable.dev/zsh-completion-guide-examples/
# 描述显示为淡色
# it only supported by gnome-terminal
# https://gist.github.com/inexorabletash/9122583
#zstyle ':completion:*:descriptions' format $'\e[2m -- %d --\e[0m'
zstyle ':completion:*:descriptions' format '%F{blue} -- %d -- %f'
zstyle ':completion:*:messages' format '%F{purple} -- %d -- %f'
# 警告显示为红色
zstyle ':completion:*:warnings' format '%F{red}%B -- No Matches Found --%b%f'
zstyle ':completion:*:corrections' format '%F{yellow}%B -- %d (errors: %e) --%b%f'
# Description for options that are not described by the completion functions, but that have exactly one argument
zstyle ':completion:*' auto-description '%F{green}Specify: %d%f'

###  Color setting
# I use http://jafrog.com/2013/11/23/colors-in-terminal.html to get color code
# colorfull completion list
#eval $(dircolors -b) # Load better one in config.zsh
export ZLSCOLORS="${LS_COLORS}"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# 错误校正
zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct

# 补全顺序:
# _complete - 普通补全函数  _extensions - 通过 *.\t 选择扩展名
# _match    - 和 _complete 类似但允许使用通配符
# _expand_alias - 展开别名 _ignored - 被 ignored-patterns 忽略掉的
# 由于某些 completer 调用的代价比较昂贵，第一次调用时不考虑它们
zstyle ':completion:*' completer _complete _extensions _match _approximate _expand_alias _ignored _files
#zstyle -e ':completion:*' completer '
#    if [[ $_last_try != "$HISTNO$BUFFER$CURSOR" ]]; then
#        _last_try="$HISTNO$BUFFER$CURSOR"
#        reply=(_expand_alias _complete _extensions _match _files)
#    else
#        reply=(_complete _ignored _correct _approximate)
#    fi'

# Increase the number of errors based on the length of the typed word.
# allow one error for every three characters typed in approximate completer
# But make sure to cap (at 7) the max-errors to avoid hanging.
zstyle -e ':completion:*:approximate:' max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric )'

zstyle ':completion:*' expand 'yes'
# I don't like expand `//` -> `/*/`, I user `//` -> `/` as default behavior in UNIX
zstyle ':completion:*' squeeze-shlashes 'yes'
zstyle ':completion::complete:*' '\\'

# 在 alias 之后补全(即把 alias 展开后补全而不是当中单独的命令)
unsetopt complete_aliases

# https://github.com/lilydjwg/dotzsh/blob/master/zshrc#L306-L312
# 插入当前的所有补全 https://www.zsh.org/mla/workers/2020/index.html {{{2
zstyle ':completion:all-matches::::' completer _all_matches _complete
zstyle ':completion:all-matches:*' old-matches true
zstyle ':completion:all-matches:*' insert true
zstyle ':completion:all-matches:*' file-patterns '%p:globbed-files' '*(-/):directories' '*:all-files'
zle -C all-matches complete-word _generic
bindkey '^Xi' all-matches

####### Command Specified Configuration #######

# kill 命令补全
compdef pkill=kill
compdef pkill=killall
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes' command 'ps -afu$USER'
zstyle ':completion:*:kill:*' ignored-patterns '0'
# Provide more processes in completion of programs like killall:
zstyle ':completion:*:processes-names' command 'ps -u $USER -o pid,user,comm,cmd -w -w | uniq'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# complete manual by their section, from grml
zstyle ':completion:*:manuals'    separate-sections true
zstyle ':completion:*:manuals.*'  insert-sections   true

# 在 .. 后不要回到当前目录
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# 允许 docker 补全时识别 -it 之类的组合命令
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# fg/bg 补全时使用 jobs id
zstyle ':completion:*:jobs' verbose true
zstyle ':completion:*:jobs' numbers true

# Search path for sudo completion
zstyle ':completion:*:sudo:*' command-path  /usr/local/sbin \
                                            /usr/local/bin  \
                                            /usr/sbin       \
                                            /usr/bin        \
                                            /sbin           \
                                            /bin            \
                                            /usr/X11R6/bin

zstyle :compinstall filename "$ZDOTDIR/.zshrc"

compdef downgrade=pactree 2>/dev/null
compdef proxychains=command
compdef prime-run=command
compdef cgproxy=command

compdef _gnu_generic ccls
compdef _gnu_generic mill amm
compdef _gnu_generic updatedb plocate
compdef _gnu_generic btrfs-list
compdef _gnu_generic zramctl swapon swapoff
compdef _gnu_generic file
compdef _gnu_generic yt-dlp
compdef _gnu_generic ProtonDB-Tags

# By default only C and C++ languages are supported for compiler flag variables. To define your own list of languages:
#cmake_langs=('C' 'C' 'CXX' 'C++')
#zstyle ':completion:*:cmake:*' languages $cmake_langs

for comp_conf_file in $ZDOTDIR/completion.d/*.zsh; do
    source $comp_conf_file
done

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4;
