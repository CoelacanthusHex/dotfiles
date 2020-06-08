alias start="sudo systemctl start"
alias stop="sudo systemctl stop"
alias status="systemctl status"
alias restart="sudo systemctl restart"
alias reload="sync && source $HOME/.zshrc && rehash"
alias archwiki='wiki-search-html'
alias vi="vim"
if (( $+commands[nvim] )); then
    alias vim="nvim"
    alias vimdiff='nvim -d'
fi
(( $+commands[hub] )) && alias git="hub"
if (( $+commands[exa] )); then
    alias ls='exa --icons  --time-style=long-iso'
else
    alias ls='ls --color=auto --human-readable --time-style=long-iso'
fi
alias l='ls -al'         # Lists in one column, hidden files.
alias ll='ls -lh'        # Lists human readable sizes.
alias lr='ll -R'         # Lists human readable sizes, recursively.
alias la='ll -A'         # Lists human readable sizes, hidden files.
alias lm='la | "$PAGER"' # Lists human readable sizes, hidden files through pager.
alias lx='ll -XB'        # Lists sorted by extension (GNU only).
alias lk='ll -Sr'        # Lists sorted by size, largest last.
alias lt='ll -tr'        # Lists sorted by date, most recent last.
alias lc='lt -c'         # Lists sorted by date, most recent last, shows change time.
alias lu='lt -u'         # Lists sorted by date, most recent last, shows access time.
(( $+commands[bat] )) && alias cat="bat --tabs=0"
#if (( $+commands[fd] )); then
#    alias clang-format-all="fd --type f '.*\.\(c\|cpp\|h\|hpp\)' . | xargs clang-format"
#else
#    alias clang-format-all="find . -type f -regex '.*\.\(c\|cpp\|h\|hpp\)' | xargs clang-format -i"
#fi
alias clang-format-all="find . -type f -regex '.*\.\(c\|cpp\|h\|hpp\)' | xargs clang-format -i"
alias gdb='gdb -q'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."
alias ........="cd ../../../../../../.."
alias setproxy="export ALL_PROXY=socks5://127.0.0.1:1080"
alias unsetproxy="unset ALL_PROXY"
alias blog-update='cd ~/blog && git add -A && git commit -m "Update Site @$(date +%Y-%m-%d-%H:%M:%S)" && git push -u origin master && cd ~'
alias rg='rg -p --smart-case'
alias diff='diff --color=auto'
#alias ppikaur='ALL_PROXY=socks5://127.0.0.1:1080 pikaur'
alias pyay='ALL_PROXY=socks5://127.0.0.1:1080 yay'
alias .="source"
alias mv='mv -v'
alias rm='rm -v'
alias cp="cp -v --reflink=auto"
alias pactree="pactree -c"
alias uptime='uptime -p'
alias tree='tree -F'
alias ssh="TERM=xterm-256color ssh"
alias bc="bc -lq"
alias :q="exit"
alias :w="sync"
alias :x="sync && exit"
alias :wq="sync && exit"
[ -x "$(command -v rankmirrors)" ] && alias rankpacman='sed "s/^#//" /etc/pacman.d/mirrorlist.pacnew | rankmirrors -n 10 - | sudo tee /etc/pacman.d/mirrorlist'
alias pb='curl -F "c=@-" "http://fars.ee/"'
alias clipboard="xclip -selection clipboard"
alias Ci="clipboard -i"
alias Co="clipboard -o"
alias df="df -h"
alias du="du -h"
alias free="free -h"
alias today="date '+%Y-%m-%d'"
alias now="date --rfc-3339=seconds"
alias dd='dd status=progress'
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
#alias myip="dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | sed 's/\"//g'"

# BSD ls colors.
export LSCOLORS='exfxcxdxbxGxDxabagacad'

# Grep colors.
export GREP_COLOR='37;45'           # BSD.
export GREP_COLORS="mt=$GREP_COLOR" # GNU.

alias grep="${aliases[grep]:-grep} --color=auto"
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
#alias stow="stow --no-folding"

# 后缀别名
#alias -s {html,htm}="firefox"
alias -s {pdf,ps,djvu}="okular"
alias -s {png,jpg,gif}="feh"
alias -s jar="java -jar"
if (( $+commands[ruffle] )); then
    alias -s swf="ruffle"
else
    alias -s swf="flashplayer"
fi


alias -g NULL="/dev/null"

# vim: ft=zsh
