# for systemd
alias start="sudo systemctl start"
alias stop="sudo systemctl stop"
alias status="systemctl status"
alias restart="sudo systemctl restart"
alias limit-run='systemd-run --user --pty --same-dir --wait --collect --slice=limit-run.slice '
alias limit-cpu='systemd-run --user --pty --same-dir --wait --collect --slice=limit-cpu.slice '
alias limit-mem='systemd-run --user --pty --same-dir --wait --collect --slice=limit-mem.slice '

(( $_in_kitty == 1 )) && alias ssh="kitty +kitten ssh"
(( $+commands[kitty] )) && (( $+commands[weechat] )) && alias kitty-weechat="kitty -o 'map kitty_mod+e kitten hints --customize-processing weechat_hints.py' -o term=xterm-256color weechat"

# reload zsh
alias reload="sync && source $HOME/.zshrc && rehash"

# No real vi
alias vi="vim"

# https://github.com/lilydjwg/dotzsh/blob/e1a678cf4743e53813a457cb33f6f1e82e5bfa39/zshrc#L875
if (( $+commands[zoxide] )); then
    eval "$(zoxide init zsh)"
    function z () {
        if [[ "$#" -eq 0 ]]; then
            __zoxide_z ''
        else
            __zoxide_z "$@"
        fi
    }
    if [[ -z $functions[j] ]]; then
        function j () {
            if [[ -t 1 ]]; then
                z "$@"
            else
                zoxide query "$@"
            fi
        }
    fi
fi
# if zoxide loads but the directory is readonly, remove the chpwd hook
if [[ ${chpwd_functions[(i)__zoxide_hook]} -le ${#chpwd_functions} && \
    -d ~/.local/share/zoxide && ! -w ~/.local/share/zoxide ]]; then
        chpwd_functions[(i)__zoxide_hook]=()
fi

# using exa instead of ls, and ls' alias
if (( $+commands[exa] )); then
    alias ls='exa --time-style=long-iso --group --git'
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

# bat using noexpandtab
(( $+commands[bat] )) && export BAT_OPTS="--tabs 0"
# using fd instead of find
if (( $+commands[fd] )); then
    alias clang-format-all='fd --type f '.*\.(c|cpp|h|hpp|hxx|cxx)' . -x clang-format -i {};'
    alias clang-tidy-all='fd --type f '.*\.(c|cpp|h|hpp|hxx|cxx)' . -x clang-tidy {};'
else
    alias clang-format-all="find . -type f -regex '.*\.(c|cpp|h|hpp)' | xargs clang-format -i"
fi

if (( $+commands[vimtrace] )); then
    (( $+commands[strace] )) && alias strace='vimtrace strace'
    (( $+commands[ltrace] )) && alias ltrace='vimtrace ltrace'
fi

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
alias pparu='cgproxy paru'

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
alias :e="vim"
alias :q="exit"
alias :w="sync"
alias :x="sync && exit"
alias :wq="sync && exit"
alias :help="man"
alias :h=:help

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
alias grep="${aliases[grep]:-grep} --color=auto --extended-regexp"
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias ncdu='ncdu --color dark'
alias ip="ip -c=auto "

# URL
alias urldecode='python3 -c "import sys, urllib.parse as up; print(up.unquote(sys.argv[1]))"'
alias urlencode='python3 -c "import sys, urllib.parse as up; print(up.quote(sys.argv[1]))"'

alias ini2json='python3 -c "import fileinput,json,configparser;c=configparser.ConfigParser(allow_no_value=True);c.read_string('"''"'.join(fileinput.input()));print(json.dumps({s: {k: c[s][k] for k in c[s]} for s in c.sections()}))"'

export LESSOPEN="| pygmentize -f console -O bg=dark %s"
export LESS='r'

alias blog-update='cd ~/blog && git add -A && git commit -m "Update Site @$(date +%Y-%m-%d-%H:%M:%S)" && git push -u origin master && cd ~'
alias .="source"
alias bc="bc -lq"
(( $+commands[rankmirrors] )) && alias rankpacman='sed "s/^#//" /etc/pacman.d/mirrorlist.pacnew | rankmirrors -n 10 - | sudo tee /etc/pacman.d/mirrorlist'

alias myip-http-detail='curl -s -L -H "Accept: application/json" "https://ipinfo.io/${1:-}" | jq "del(.readme, .loc, .postal)"'
# availible: ifconfig.co icanhazip.com ifconfig.me myip.country/ip
alias myip-http='curl -L https://ifconfig.me'
alias myip-http-ipv4='curl -L https://ipv4.icanhazip.com'
alias myip-http-ipv6='curl -L https://ipv6.icanhazip.com'
if (( $+commands[dig] )); then
    alias myip-dns="dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | sed 's/\"//g'"
elif (( $+commands[kdig] )); then
    alias myip-dns="kdig TXT +short o-o.myaddr.l.google.com @ns1.google.com | sed 's/\"//g'"
fi
alias myipv4=myip-http-ipv4
alias myipv6=myip-http-ipv6
if (( $+commands[curl] )); then
    alias myip=myip-http-detail
else
    alias myip=myip-dns
fi

alias tinc-family="sudo tinc -n family"

# https://github.com/lilydjwg/dotzsh/blob/313050449529c84914293283691da1e824d779f5/zshrc#L438
# --inplace has issues with -H https://lists.opensuse.org/opensuse-bugs/2012-10/msg02084.html
alias xcp="rsync -aviHAXKhS --one-file-system --partial --info=progress2 --atimes --open-noatime --delete --exclude='*~' --exclude=__pycache__"

# https://github.com/lilydjwg/dotzsh/blob/313050449529c84914293283691da1e824d779f5/zshrc#L375
# grc aliases
if (( $+aliases[colourify] )); then
    # default is better
    unalias gcc g++ 2>/dev/null || true
    # bug: https://github.com/garabik/grc/issues/72
    unalias mtr     2>/dev/null || true
    # buffering issues: https://github.com/garabik/grc/issues/25
    unalias ping    2>/dev/null || true
fi

# 后缀别名
if (( $+commands[okular] )) && (( $_in_gui == 1 )); then
    alias -s {pdf,ps,djvu}="okular"
fi
# https://askubuntu.com/questions/97542/how-do-i-make-my-terminal-display-graphical-pictures
if (( $+commands[gwenview] )) && (( $_in_gui == 1 )); then
    alias -s {png,jpg,jpeg,gif}="gwenview"
    alias pic-viewer="gwenview"
elif (( $+commands[feh] )) && (( $_in_gui == 1 )); then
    alias -s {png,jpg,jpeg,gif}="feh"
    alias pic-viewer="feh"
elif (( $+commands[display] )) && (( $_in_gui == 1 )); then
    alias -s {png,jpg,jpeg,gif}="display"
    alias pic-viewer="display"
elif (( $+commands[viu] )); then
    # https://github.com/atanunq/viu
    alias -s {png,jpg,jpeg,gif}="viu"
    alias pic-viewer="viu"
elif (( $+commands[kitty] )) && (( $_in_kitty == 1 )); then
    # https://sw.kovidgoyal.net/kitty/kittens/icat/
    alias -s {png,jpg,jpeg,gif}="kitty +kitten icat"
    alias pic-viewer="kitty +kitten icat"
elif (( $+commands[catimg] )); then
    # https://github.com/posva/catimg
    alias -s {png,jpg,jpeg,gif}="catimg"
    alias pic-viewer="catimg"
fi
# https://superuser.com/questions/174522/command-line-svg-and-image-file-viewer-in-linux
if (( $+commands[gwenview] )) && (( $_in_gui == 1 )); then
    alias -s svg="gwenview"
    alias svg-viewer="gwenview"
elif (( $+commands[inkview] )) && (( $_in_gui == 1 )); then
    alias -s svg="inkview"
    alias svg-viewer="inkview"
elif (( $+commands[feh] )) && (( $_in_gui == 1 )); then
    alias -s svg="feh --conversion-timeout 1"
    alias svg-viewer="feh --conversion-timeout 1"
elif (( $+commands[display] )) && (( $_in_gui == 1 )); then
    alias -s svg="display"
    alias svg-viewer="display"
fi

alias -s jar="java -jar"
if (( $+commands[ruffle] )); then
    alias -s swf="ruffle"
elif (( $+commands[flashplayer] )); then
    alias -s swf="flashplayer"
fi

# 全局别名
alias -g NULL="/dev/null"
# 当前目录下最后修改的文件
# 来自 https://roylez.info/2010-03-06-zsh-recent-file-alias/
alias -g NN="*(oc[1])"
alias -g NNF="*(oc[1].)"
alias -g NND="*(oc[1]/)"
alias -g NUL="/dev/null"
alias -g XS='"$(xsel)"'
alias -g ANYF='**/*[^~](.)'

alias -g L='| less'


# 路径别名
#hash -d tmp="/tmp"

# vim: ft=zsh sw=4 ts=8 sts=4 et
