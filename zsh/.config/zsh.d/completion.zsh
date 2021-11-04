autoload -Uz compinit
compinit -d "$ZSH_COMPDUMP"

autoload -U +X bashcompinit && bashcompinit
#[ -f /usr/share/bash-completion/bash_completion ] && source /usr/share/bash-completion/bash_completion
#(( $+commands[stack] )) && eval "$(stack --bash-completion-script stack)"

#彩色补全菜单
eval $(dircolors -b)
export ZLSCOLORS="${LS_COLORS}"
zmodload zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

zstyle ':completion:*:cd:*' ignore-parents parent pwd

# Some functions, like _apt and _dpkg, are very slow. We can use a cache in
# order to speed things up
zstyle ':completion:*' use-cache  yes
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcache"

# ignore duplicate entries
zstyle ':completion:*:history-words'   remove-all-dups yes
zstyle ':completion:*:history-words'   stop yes

# define files to ignore for zcompile
zstyle ':completion:*:*:zcompile:*'    ignored-patterns '(*~|*.zwc)'
zstyle ':completion:correct:'          prompt 'correct to: %e'

# Ignore completion functions for commands you don't have:
zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'

# Provide more processes in completion of programs like killall:
zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'

#修正大小写
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

#kill 命令补全
compdef pkill=kill
compdef pkill=killall
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes' command 'ps -afu$USER'

zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'

#错误校正
zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate

# allow one error for every three characters typed in approximate completer
zstyle ':completion:*:approximate:'    max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'

zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-shlashes 'yes'
zstyle ':completion::complete:*' '\\'

zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES

# Search path for sudo completion
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin \
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
compdef _gnu_generic exa pamixer

zstyle ':completion:*:*:x:*' file-patterns \
  '*.{7z,bz2,gz,rar,tar,tbz,tgz,zip,chm,xz,zst,exe,xpi,apk,maff,crx,deb,jar,lrz,lzma,rpm,lz,lz4,tbz,tbz2,tlz,txz,tzst}:compressed-files:compressed\ files *(-/):directories:directories'
zstyle ':completion:*:*:feh:*' file-patterns '*.{png,gif,jpg,svg}:images:images *(-/):directories:directories'
zstyle ':completion:*:*:sxiv:*' file-patterns '*.{png,gif,jpg}:images:images *(-/):directories:directories'
zstyle ':completion:*:*:mpv:*' file-patterns '*.(#i)(flv|mp4|webm|mkv|wmv|mov|avi|mp3|ogg|wma|flac|wav|aiff|m4a|m4b|m4v|gif|ifo)(-.) *(-/):directories' '*:all-files'

# ignore for vim
# https://github.com/MaskRay/Config/blob/master/home/.zshrc#L170
zstyle ':completion:*:*:vim:*:*files' ignored-patterns '*.(avi|mkv|rmvb|pyc|wmv)'
zstyle ':completion:*:*:nvim:*:*files' ignored-patterns '*.(avi|mkv|rmvb|pyc|wmv)'

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
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
