# for systemd
alias start="sudo systemctl start"
alias stop="sudo systemctl stop"
alias status="systemctl status"
alias restart="sudo systemctl restart"
alias limit-run='systemd-run --user --pty --same-dir --wait --collect --slice=limit-run.slice '
alias limit-cpu='systemd-run --user --pty --same-dir --wait --collect --slice=limit-cpu.slice '
alias limit-mem='systemd-run --user --pty --same-dir --wait --collect --slice=limit-mem.slice '

# reload zsh
alias reload="sync && source $HOME/.zshrc && rehash"

# No real vi
alias vi="vim"

# Enable aliases to be sudo’ed
# http://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
alias sudo='sudo '

(( $+commands[hub] )) && alias git="hub"

# using exa instead of ls, and ls' alias
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

# using bat instead of cat, fd instead of find
(( $+commands[bat] )) && alias cat="bat --tabs=0"
if (( $+commands[fd] )); then
    alias clang-format-all='fd --type f '.*\.(c|cpp|h|hpp|hxx|cxx)' . -x clang-format -i {};'
    alias clang-tidy-all='fd --type f '.*\.(c|cpp|h|hpp|hxx|cxx)' . -x clang-tidy {};'
else
    alias clang-format-all="find . -type f -regex '.*\.(c|cpp|h|hpp)' | xargs clang-format -i"
fi
#alias clang-format-all="find . -type f -regex '.*\.\(c\|cpp\|h\|hpp\)' | xargs clang-format -i"

# some cd
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."
alias ........="cd ../../../../../../.."

# some proxy
alias setproxy="export ALL_PROXY=socks5://127.0.0.1:1089"
alias unsetproxy="unset ALL_PROXY"
alias pyay='ALL_PROXY=socks5://127.0.0.1:1089 yay'
alias pparu='ALL_PROXY=socks5://127.0.0.1:1089 paru'

# add progress
alias dd='dd status=progress'
alias mv='mv -v'
alias rm='rm -v'
# reflink in btrfs/xfs
alias cp="cp -v --reflink=auto --sparse=auto"

# pastebin && clipboard
alias pb='curl -F "c=@-" "http://fars.ee/"'
alias clipboard="xclip -selection clipboard"
alias Ci="clipboard -i"
alias Co="clipboard -o"

# better format
alias uptime='uptime -p'
alias tree='tree -F'
alias df="df -h"
alias du="du -h"
alias free="free -h"
alias today="date '+%Y-%m-%d'"
alias now="date --rfc-3339=seconds"

# Vim style alias
alias ':e'=vim
alias :q="exit"
alias :w="sync"
alias :x="sync && exit"
alias :wq="sync && exit"

# GDB
alias gdb-gef="command gdb -x $XDG_CONFIG_HOME/gdb/gdbinit-gef"
alias gdb-pwndbg="command gdb -x $XDG_CONFIG_HOME/gdb/gdbinit-pwndbg"
alias gdb-peda="command gdb -x $XDG_CONFIG_HOME/gdb/gdbinit-peda"
alias gdb='gdb-gef -q'

# BSD ls colors.
export LSCOLORS='exfxcxdxbxGxDxabagacad'

# Grep colors.
export GREP_COLOR='37;45'           # BSD.
export GREP_COLORS="mt=$GREP_COLOR" # GNU.

# add color
alias diff='diff --color=auto'
alias pactree="pactree -c"
alias ssh="TERM=xterm-256color ssh"
alias grep="${aliases[grep]:-grep} --color=auto"
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias ncdu='ncdu --color dark'
alias ip="ip -c=auto "

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

alias git-log='git log --all --decorate --oneline --graph'

# URL
alias urldecode='python3 -c "import sys, urllib.parse as up; print(up.unquote(sys.argv[1]))"'
alias urlencode='python3 -c "import sys, urllib.parse as up; print(up.quote(sys.argv[1]))"'

export LESSOPEN="| pygmentize -f console -O bg=dark %s"
export LESS='R'

alias blog-update='cd ~/blog && git add -A && git commit -m "Update Site @$(date +%Y-%m-%d-%H:%M:%S)" && git push -u origin master && cd ~'
alias rg='rg -p --smart-case --context=3'
alias .="source"
alias bc="bc -lq"
(( $+commands[rankmirrors] )) && alias rankpacman='sed "s/^#//" /etc/pacman.d/mirrorlist.pacnew | rankmirrors -n 10 - | sudo tee /etc/pacman.d/mirrorlist'
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
#alias myip="dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | sed 's/\"//g'"

# vim: ft=zsh
