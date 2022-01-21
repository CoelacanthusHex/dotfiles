zmodload zsh/complist

# using hjkl to select completion menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

autoload -Uz compinit
compinit -d "$ZSH_COMPDUMP"

autoload -U +X bashcompinit && bashcompinit
#[[ -f /usr/share/bash-completion/bash_completion ]] && source /usr/share/bash-completion/bash_completion
#[[ -f /usr/share/php/arcanist/support/shell/rules/bash-rules.sh ]] && source /usr/share/php/arcanist/support/shell/rules/bash-rules.sh
#(( $+commands[stack] )) && eval "$(stack --bash-completion-script stack)"

# enable hidden files completion
_comp_options+=(globdots)

# Some functions, like _apt and _dpkg, are very slow. We can use a cache in
# order to speed things up
zstyle ':completion:*' use-cache yes
_cache_dir=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcache
zstyle ':completion:*' cache-path $_cache_dir
unset _cache_dir

# ignore duplicate entries
zstyle ':completion:*:history-words'   remove-all-dups yes
zstyle ':completion:*:history-words'   stop yes

# define files to ignore for zcompile
zstyle ':completion:*:*:zcompile:*'    ignored-patterns '(*~|*.zwc)'
zstyle ':completion:correct:'          prompt 'correct to: %e'

# ignore completion functions for commands you don't have:
zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'

# Enable case-insensitive completion
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**'

# when correcting, original string should be added as a possible completion
zstyle ':completion:*' original true

zstyle ':completion:*' verbose yes
zstyle ':completion:*:matches' group yes
zstyle ':completion:*:options' description yes

###  Color setting
# I use http://jafrog.com/2013/11/23/colors-in-terminal.html to get color code
# colorfull completion list
#eval $(dircolors -b) # Load better one in config.zsh
export ZLSCOLORS="${LS_COLORS}"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Description for options that are not described by the completion functions, but that have exactly one argument
zstyle ':completion:*' auto-description '%F{green}Specify: %d%f'

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

# 错误校正
zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
# _extensions 为 *. 补全扩展名
# 在最后尝试使用文件名
if is-at-least 5.0.5; then
    zstyle ':completion:*' completer _complete _extensions _match _approximate _expand_alias _ignored _files
else
    zstyle ':completion:*' completer _complete _match _approximate _expand_alias _ignored _files
fi

# Increase the number of errors based on the length of the typed word.
# allow one error for every three characters typed in approximate completer
# But make sure to cap (at 7) the max-errors to avoid hanging.
zstyle -e ':completion:*:approximate:' max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric )'

zstyle ':completion:*' expand 'yes'
# I don't like expand `//` -> `/*/`, I user `//` -> `/` as default behavior in UNIX
zstyle ':completion:*' squeeze-shlashes 'yes'
zstyle ':completion::complete:*' '\\'

zstyle ':completion:*' menu select
# 分组显示
zstyle ':completion:*' group-name ''

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

### Autosuggest Setting
export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)
export ZSH_AUTOSUGGEST_USE_ASYNC=true
# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
    OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
    zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}
pastefinish() {
    zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
# https://github.com/zsh-users/zsh-autosuggestions/issues/351
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste accept-line)

_ZSH_PLUGINS="/usr/share/zsh/plugins"
_enabled_plugins=(
    zsh-autosuggestions
    zsh-history-substring-search
    zsh-syntax-highlighting
)
for _zsh_plugin in $_enabled_plugins[@]; do
    [[ ! -r "$_ZSH_PLUGINS/$_zsh_plugin/$_zsh_plugin.zsh" ]] || source $_ZSH_PLUGINS/$_zsh_plugin/$_zsh_plugin.zsh
done

# https://github.com/zsh-users/zsh-history-substring-search#usage
zmodload zsh/terminfo
#bindkey "$terminfo[kcuu1]" history-substring-search-up
#bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
export HISTORY_SUBSTRING_SEARCH_PREFIXED=true

####### Command Specified Configuration #######

# kill 命令补全
compdef pkill=kill
compdef pkill=killall
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes' command 'ps -afu$USER'
# Provide more processes in completion of programs like killall:
zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# complete manual by their section, from grml
zstyle ':completion:*:manuals'    separate-sections true
zstyle ':completion:*:manuals.*'  insert-sections   true

# 在 .. 后不要回到当前目录
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# Search path for sudo completion
zstyle ':completion:*:sudo:*' command-path  /usr/local/sbin \
                                            /usr/local/bin  \
                                            /usr/sbin       \
                                            /usr/bin        \
                                            /sbin           \
                                            /bin            \
                                            /usr/X11R6/bin

zstyle :compinstall filename "${HOME}/.zshrc"

compdef downgrade=pactree 2>/dev/null
compdef proxychains=command
compdef prime-run=command
compdef cgproxy=command

compdef _gnu_generic ccls
compdef _gnu_generic mill amm
compdef _gnu_generic updatedb plocate
compdef _gnu_generic btrfs-list
compdef _gnu_generic zramctl swapon swapoff

# By default only C and C++ languages are supported for compiler flag variables. To define your own list of languages:
#cmake_langs=('C' 'C' 'CXX' 'C++')
#zstyle ':completion:*:cmake:*' languages $cmake_langs

source $XDG_CONFIG_HOME/zsh.d/completion.d/*.zsh

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4;
