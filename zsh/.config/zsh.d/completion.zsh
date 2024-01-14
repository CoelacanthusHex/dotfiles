# Expand the path, and also complete the word
# /v/c/p/p => /var/cache/pacman/pkg
setopt complete_in_word
# Different columns in the completion list can use different column widths
setopt listpacked
# Completing arguments of the form identifier=path
setopt magic_equal_subst
# Completion after alias (i.e. complete after expansion of alias instead of a separate command)
unsetopt complete_aliases

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
_comp_files=($ZSH_COMPDUMP(#qNmh-20))
if (( $#_comp_files )); then
    compinit -C -d "$ZSH_COMPDUMP"
else
    compinit -d "$ZSH_COMPDUMP"
fi
unset _comp_files

# Disable old completion system
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

# enable hidden files completion
_comp_options+=(globdots)

# Some functions, like _apt and _dpkg, are very slow. We can use a cache in
# order to speed things up
zstyle ':completion:*' use-cache yes
_cache_dir=$ZSH_CACHE_HOME/zcache
zstyle ':completion:*' cache-path $_cache_dir
zstyle ':completion:*:complete:*' cache-policy _c10s_caching_policy
function _c10s_caching_policy() {
    # Cache Policy: Invalid if not present or 14 days ago
    [[ ! -f $1 && -n "$1"(#qNm+14) ]]
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

# Enhanced filename completion
# 0 - Exact match               ( Abc -> Abc )
# 1 - Capitalization correction ( abc -> Abc )
# 2 - Word completion           ( f-b -> foo-bar )
# 3 - Suffix completion         ( .cxx -> foo.cxx )
zstyle ':completion:*:(argument-rest|files):*' matcher-list \
    '' \
    'm:{[:lower:]-}={[:upper:]_}' \
    'r:|[.,_-]=* r:|=*' \
    'r:|.=* r:|=*'

# when correcting, original string should be added as a possible completion
zstyle ':completion:*' original true

# Menu complete
zstyle ':completion:*' menu yes select
# Display by group
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*:matches' group yes
zstyle ':completion:*:options' description yes
# https://thevaluable.dev/zsh-completion-guide-examples/
# Descriptions are shown in tint
# it only supported by gnome-terminal
# https://gist.github.com/inexorabletash/9122583
#zstyle ':completion:*:descriptions' format $'\e[2m -- %d --\e[0m'
zstyle ':completion:*:descriptions' format '%F{blue} -- %d -- %f'
zstyle ':completion:*:messages' format '%F{purple} -- %d -- %f'
# Warnings are displayed in red
zstyle ':completion:*:warnings' format '%F{red}%B -- No Matches Found --%b%f'
zstyle ':completion:*:corrections' format '%F{yellow}%B -- %d (errors: %e) --%b%f'
# Description for options that are not described by the completion functions, but that have exactly one argument
zstyle ':completion:*' auto-description 'Specify: %d'

## Color setting
# I use http://jafrog.com/2013/11/23/colors-in-terminal.html to get color code
# colorfull completion list
#eval $(dircolors -b) # Load better one in config.zsh
export ZLSCOLORS="${LS_COLORS}"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Error correction
zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct

# Completion order:
# _complete     - Normal completion function
# _extensions   - Completing extensions via *.\t
# _match        - Like _complete but allows wildcards
# _approximate  - Like _complete but allows errors
# _expand_alias - Expand alias
# _ignored      - Ignored by ignored-patterns
zstyle ':completion:*' completer _complete _extensions _match _approximate _expand_alias _ignored _files

# Increase the number of errors based on the length of the typed word.
# allow one error for every three characters typed in approximate completer
# But make sure to cap (at 7) the max-errors to avoid hanging.
zstyle -e ':completion:*:approximate:' max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric )'

zstyle ':completion:*' expand 'yes'
# I don't like expand `//` -> `/*/`, I user `//` -> `/` as default behavior in UNIX
zstyle ':completion:*' squeeze-shlashes 'yes'
zstyle ':completion::complete:*' '\\'

# https://github.com/lilydjwg/dotzsh/blob/master/zshrc#L306-L312
# 插入当前的所有补全 https://www.zsh.org/mla/workers/2020/index.html
zstyle ':completion:all-matches::::' completer _all_matches _complete
zstyle ':completion:all-matches:*' old-matches true
zstyle ':completion:all-matches:*' insert true
zstyle ':completion:all-matches:*' file-patterns '%p:globbed-files' '*(#q-/):directories' '*:all-files'
zle -C all-matches complete-word _generic
bindkey "$key[Ctrl-X]$key[I]" all-matches

####### Command Specified Configuration #######

autoload -Uz compdef

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

# Do not go back to current directory after ..
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# Allow docker completion to recognize combined commands like -it
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# Use jobs id for fg/bg completion
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
# v4l2
compdef _gnu_generic cec-compliance cec-ctl cec-follower cx18-ctl decode_tm6000 dvb-fe-tool dvb-format-convert dvbv5-daemon dvbv5-scan dvbv5-zap ir-ctl ir-keytable media-ctl qv4l2 qvidcap rds-ctl v4l2-compliance v4l2-ctl v4l2-dbg v4l2-sysfs-path
compdef _gnu_generic psig

for comp_conf_file in $ZDOTDIR/completion.d/*.zsh; do
    source $comp_conf_file
done

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4;
