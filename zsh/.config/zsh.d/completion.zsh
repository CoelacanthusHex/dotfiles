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

# 在 .. 后不要回到当前目录
zstyle ':completion:*:cd:*' ignore-parents parent pwd

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

# Ignore completion functions for commands you don't have:
zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'

#修正大小写
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
# 描述显示为淡色
zstyle ':completion:*:descriptions' format $'\e[2m -- %d --\e[0m'
zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
# 警告显示为红色
zstyle ':completion:*:warnings' format $'\e[91m -- No Matches Found --\e[0m'
zstyle ':completion:*:corrections' format $'\e[93m -- %d (errors: %e) --\e[0m'

#错误校正
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

# allow one error for every three characters typed in approximate completer
zstyle ':completion:*:approximate:'    max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'

zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-shlashes 'yes'
zstyle ':completion::complete:*' '\\'

zstyle ':completion:*' menu select
# 分组显示
zstyle ':completion:*' group-name ''

# 补全 alias
setopt complete_aliases

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

# kill 命令补全
compdef pkill=kill
compdef pkill=killall
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes' command 'ps -afu$USER'
# Provide more processes in completion of programs like killall:
zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'

# complete user-commands for git-*
# https://pbrisbin.com/posts/deleting_git_tags_with_style/
# /usr/share/zsh/functions/Completion/Unix/_git
#zstyle ':completion:*:*:git:*' user-commands ${${(M)${(k)commands}:#git-*}/git-/}
# we can add all git-* subcommand without description using command above,
# but we can add each git-* subcommand with description using command below
(( $+commands[git-clang-format] )) && zstyle ':completion:*:*:git:*' user-commands clang-format:'format files between two commits.(If only 1/0, between workspace and <commit>(default: HEAD) )'
(( $+commands[git-filter-repo] )) && zstyle ':completion:*:*:git:*' user-commands filter-repo:'rapidly rewrite entire repository history using user-specified filters'
(( $+commands[git-lfs] )) && zstyle ':completion:*:*:git:*' user-commands lfs:'managing and versioning large files in association with a Git repository'
(( $+commands[git-review] )) && zstyle ':completion:*:*:git:*' user-commands review:'help submitting git branches to Gerrit for review'
(( $+commands[git-latexdiff] )) && zstyle ':completion:*:*:git:*' user-commands latexdiff:'call latexdiff on two Git revisions of a file. (latexdiff [old] [new], new defaults to HEAD, -- is workspace)'
(( $+commands[git-sizer] )) && zstyle ':completion:*:*:git:*' user-commands sizer:'compute various size metrics for a Git repository, flagging those that might cause problems'
(( $+commands[git-cliff] )) && zstyle ':completion:*:*:git:*' user-commands cliff:'highly customizable changelog generator'
(( $+commands[git-absorb] )) && zstyle ':completion:*:*:git:*' user-commands absorb:'automatically absorb staged changes into your current branch'
(( $+commands[git-crypt] )) && zstyle ':completion:*:*:git:*' user-commands crypt:'transparent file encryption in git'
(( $+commands[git-revise] )) && zstyle ':completion:*:*:git:*' user-commands revise:'rebase staged changes onto the given commit, and rewrite history to incorporate these changes'
# git-extras will add completion in file below as command above
[[ ! -r "/usr/share/doc/git-extras/git-extras-completion.zsh" ]] || source /usr/share/doc/git-extras/git-extras-completion.zsh

# disable fallback to filename completion
zstyle ':completion:*:*:git*:*' use-fallback false

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
compdef _gnu_generic exa pamixer

zstyle ':completion:*:*:x:*' file-patterns \
    '*.{7z,bz2,gz,rar,tar,tbz,tgz,zip,chm,xz,zst,exe,xpi,apk,maff,crx,deb,jar,lrz,lzma,rpm,lz,lz4,tbz,tbz2,tlz,txz,tzst,cbz,cbr,exe,epub,cpio,cba,ace,zpaq,arc}:compressed-files:compressed\ files *(-/):directories:directories'
    
zstyle ':completion:*:*:feh:*' file-patterns '*.{png,gif,jpg,svg}:images:images *(-/):directories:directories'
zstyle ':completion:*:*:sxiv:*' file-patterns '*.{png,gif,jpg}:images:images *(-/):directories:directories'
zstyle ':completion:*:*:mpv:*' file-patterns '*.(#i)(flv|mp4|webm|mkv|wmv|mov|avi|mp3|ogg|wma|flac|wav|aiff|m4a|m4b|m4v|gif|ifo)(-.) *(-/):directories' '*:all-files'

# ignore for vim
# https://github.com/MaskRay/Config/blob/master/home/.zshrc#L170
zstyle ':completion:*:*:vim:*:*files' ignored-patterns '*.(avi|mkv|rmvb|pyc|wmv)'
zstyle ':completion:*:*:nvim:*:*files' ignored-patterns '*.(avi|mkv|rmvb|pyc|wmv)'

# https://github.com/zsh-users/zsh/blob/zsh-5.8/Completion/Unix/Command/_ipsec#L6-L8
#zstyle ':completion:*:(ipsec|strongswan)/*' gain-privileges yes
# https://github.com/zsh-users/zsh/blob/zsh-5.8/Completion/Unix/Command/_swanctl#L6-L8
#zstyle ':completion:*:swanctl/*' gain-privileges yes

# By default only C and C++ languages are supported for compiler flag variables. To define your own list of languages:
#cmake_langs=('C' 'C' 'CXX' 'C++')
#zstyle ':completion:*:cmake:*' languages $cmake_langs


# vim: ft=zsh sw=4 ts=8 sts=4 et
