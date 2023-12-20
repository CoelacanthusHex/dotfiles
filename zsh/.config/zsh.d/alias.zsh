[[ -s "$ZDOTDIR/plugins/grc.zsh" ]] && source "$ZDOTDIR/plugins/grc.zsh"

# for systemd
alias limit-run='systemd-run --user --pty --same-dir --wait --collect --slice=limit-run.slice '
alias limit-cpu='systemd-run --user --pty --same-dir --wait --collect --slice=limit-cpu.slice '
alias limit-mem='systemd-run --user --pty --same-dir --wait --collect --slice=limit-mem.slice '

# reload zsh
alias reload="sync && exec zsh"

# https://github.com/lilydjwg/dotzsh/blob/e1a678cf4743e53813a457cb33f6f1e82e5bfa39/zshrc#L875
if (( $+commands[zoxide] )); then
    export _ZO_FZF_OPTS="--border=sharp"
    # FIXME: Don't use smartcache for unexcepted update every startup
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
    -d "$XDG_DATA_HOME/zoxide" && ! -w "$XDG_DATA_HOME/zoxide" ]]; then
        chpwd_functions[(i)__zoxide_hook]=()
fi

# using eza instead of ls, and ls' alias
if (( $+commands[eza] )); then
    # Waiting for https://github.com/eza-community/eza/pull/58
    alias ls='eza --color=auto --icons=never --time-style=long-iso --group --group-directories-first --header --git'
elif (( $+commands[exa] )); then
    # Workaround for https://github.com/ogham/exa/issues/856
    # Waiting for https://github.com/ogham/exa/pull/867
    alias ls='env -u TZ exa --time-style=long-iso --group --group-directories-first --header --git'
else
    alias ls='ls --color=auto --human-readable --time-style=long-iso --hyperlink=auto'
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

# using fd instead of find
if (( $+commands[fd] )); then
    alias clang-format-all="fd --type f '.*\.(c|cpp|h|hpp|hxx|cxx)' . -x clang-format -i {};"
    alias clang-tidy-all="fd --type f '.*\.(c|cpp|h|hpp|hxx|cxx)' . -x clang-tidy {};"
else
    alias clang-format-all="find . -type f -regex '.*\.(c|cpp|h|hpp)' | xargs clang-format -i"
fi

if (( $+commands[vimtrace] )); then
    (( $+commands[strace] )) && alias strace='vimtrace strace'
    (( $+commands[ltrace] )) && alias ltrace='vimtrace ltrace'
fi

# cargo install swapview
(( $+commands[swapview] )) && alias swapview-continuous='watch -n 1 "swapview | tail -\$((\$LINES - 2)) | cut -b -\$COLUMNS"'

# add progress
alias dd='dd status=progress'
alias mv='mv -v'
alias rm='rm -v'
# reflink in btrfs/xfs
alias cp="cp -v --reflink=auto --sparse=auto"

# pastebin && clipboard
alias pb-fc='curl -F "c=@-" "http://fars.ee/"'
alias pb-mgt='curl -F "c=@-" "https://pb.mgt.moe/"'
alias pb-0x0='curl -F "file=@-" "https://0x0.st/"'
alias pb-envs='curl -F "file=@-" "https://envs.sh/"'
alias pb-nickcao='curl --data-binary @- https://pb.nichi.co/'
alias pb=pb-mgt

# better format
# use $aliases[command] to set nested alias
# grc.zsh will set alias before
alias today="date '+%Y-%m-%d'"
alias now="date --rfc-3339=seconds"
alias list-mount="mount -l | column -t"
alias lsmount=list-mount
if (( $COLUMNS >= 80 )); then
    alias vmstat="$aliases[vmstat] -w"
fi

# Vim style alias
alias :e="vim"
alias :q="exit"
alias :w="sync"
alias :x="sync && exit"
alias :wq="sync && exit"
alias :help="man"
alias :h=:help

# GDB
alias gdb-gef="command gdb -q -x $XDG_CONFIG_HOME/gdb/gdbinit-gef"
alias gdb-pwndbg="command gdb -q -x $XDG_CONFIG_HOME/gdb/gdbinit-pwndbg"
alias gdb-peda="command gdb -q -x $XDG_CONFIG_HOME/gdb/gdbinit-peda"
alias gdb-base="command gdb -q"
alias gdb=gdb-base

# add color
if (( ! $+aliases[colourify] ));then
    alias diff="diff --color=auto"
    alias ip="ip -c=auto "
fi
alias pactree="pactree -c"
# not need for konsole
#alias ssh="TERM=xterm-256color ssh"
alias grep="${aliases[grep]:-grep} --color=auto"
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias ncdu='ncdu --color dark'

# URL
alias urldecode='python3 -c "import sys, urllib.parse as up; print(up.unquote(sys.argv[1]))"'
alias urlencode='python3 -c "import sys, urllib.parse as up; print(up.quote(sys.argv[1]))"'

alias ini2json='python3 -c "import fileinput,json,configparser;c=configparser.ConfigParser(allow_no_value=True);c.read_string('"''"'.join(fileinput.input()));print(json.dumps({s: {k: c[s][k] for k in c[s]} for s in c.sections()}))"'

alias blog-update='cd ~/blog && git add -A && git commit -m "Update Site @$(date +%Y-%m-%d-%H:%M:%S)" && git push -u origin master && cd ~'
alias .="source"
alias bc="bc -lq"

if (( $+commands[curl] )) && (( $+commands[jaq] )); then # cURL and jaq
    alias myip-http-detail='curl -s -L -H "Accept: application/json" "https://ipinfo.io/${1:-}" | jq "del(.readme, .loc, .postal)"'
elif (( $+commands[curl] )) && (( $+commands[jq] )); then # cURL and jq
    alias myip-http-detail='curl -s -L -H "Accept: application/json" "https://ipinfo.io/${1:-}" | jq "del(.readme, .loc, .postal)"'
elif (( $+commands[xh] )); then  # HTTPie written in Rust
    alias myip-http-detail="xh --body https://ipinfo.io/ Accept:application/json"
elif (( $+commands[http] )); then # HTTPie
    alias myip-http-detail="http --body https://ipinfo.io/ Accept:application/json"
fi
# availible: ifconfig.co icanhazip.com ifconfig.me myip.country/ip ip.envs.net
alias myip-http='curl -L https://ifconfig.me'
alias myip-http-ipv4='curl -L https://ipv4.icanhazip.com'
alias myip-http-ipv6='curl -L https://ipv6.icanhazip.com'
if (( $+commands[kdig] )); then
    alias myip-dns="kdig TXT +short o-o.myaddr.l.google.com @ns1.google.com | sed 's/\"//g'"
elif (( $+commands[dig] )); then
    alias myip-dns="dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | sed 's/\"//g'"
fi
alias myipv4=myip-http-ipv4
alias myipv6=myip-http-ipv6
if (( $+aliases[myip-http-detail] )); then
    alias myip=myip-http-detail
else
    alias myip=myip-dns
fi

alias tinc-family="sudo tinc -n family"

# https://github.com/lilydjwg/dotzsh/blob/313050449529c84914293283691da1e824d779f5/zshrc#L438
# --inplace has issues with -H https://lists.opensuse.org/opensuse-bugs/2012-10/msg02084.html
alias xcp="rsync -aviHAXKhS --one-file-system --partial --info=progress2 --atimes --open-noatime --delete --exclude='*~' --exclude=__pycache__"

alias nicest="chrt -i 0 ionice -c3 "

# suffix alias
if (( $+commands[okular] )) && [[ ! "$XDG_SESSION_TYPE" =~ "tty|unspecified" ]]; then
    alias -s {pdf,ps,djvu}="okular"
fi
# https://askubuntu.com/questions/97542/how-do-i-make-my-terminal-display-graphical-pictures
if (( $+commands[gwenview] )) && [[ ! "$XDG_SESSION_TYPE" =~ "tty|unspecified" ]]; then
    alias -s {png,jpg,jpeg,gif}="gwenview"
elif (( $+commands[feh] )) && [[ ! "$XDG_SESSION_TYPE" =~ "tty|unspecified" ]]; then
    alias -s {png,jpg,jpeg,gif}="feh"
elif (( $+commands[display] )) && [[ ! "$XDG_SESSION_TYPE" =~ "tty|unspecified" ]]; then
    alias -s {png,jpg,jpeg,gif}="display"
elif (( $+commands[viu] )); then
    # https://github.com/atanunq/viu
    alias -s {png,jpg,jpeg,gif}="viu"
elif (( $+commands[kitty] )) && [[ "$TERM" == xterm-kitty ]]; then
    # https://sw.kovidgoyal.net/kitty/kittens/icat/
    alias -s {png,jpg,jpeg,gif}="kitty +kitten icat"
elif (( $+commands[catimg] )); then
    # https://github.com/posva/catimg
    alias -s {png,jpg,jpeg,gif}="catimg"
fi
# https://superuser.com/questions/174522/command-line-svg-and-image-file-viewer-in-linux
if (( $+commands[gwenview] )) && [[ ! "$XDG_SESSION_TYPE" =~ "tty|unspecified" ]]; then
    alias -s svg="gwenview"
elif (( $+commands[inkview] )) && [[ ! "$XDG_SESSION_TYPE" =~ "tty|unspecified" ]]; then
    alias -s svg="inkview"
elif (( $+commands[feh] )) && [[ ! "$XDG_SESSION_TYPE" =~ "tty|unspecified" ]]; then
    alias -s svg="feh --conversion-timeout 1"
elif (( $+commands[display] )) && [[ ! "$XDG_SESSION_TYPE" =~ "tty|unspecified" ]]; then
    alias -s svg="display"
fi

alias -s jar="java -jar"
if (( $+commands[ruffle] )); then
    alias -s swf="ruffle"
elif (( $+commands[flashplayer] )); then
    alias -s swf="flashplayer"
fi

# global alias
alias -g NULL="/dev/null"
# https://roylez.info/2010-03-06-zsh-recent-file-alias/
# The last modified file in the current directory
alias -g NN="*(#qoc[1])"
# The last modified regular file in the current directory
alias -g NNF="*(#qoc[1].)"
# The last modified directory in the current directory
alias -g NND="*(#qoc[1]/)"
alias -g NUL="/dev/null"
alias -g XS='"$(xsel)"'
alias -g ANYF='**/*[^~](#q.)'

alias -g L='| less'


# path alias
#hash -d tmp="/tmp"

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4;
