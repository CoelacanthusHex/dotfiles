# zsh_stats from oh-my-zsh https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/functions.zsh
function command_freq_stats() {
    fc -l 1 | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n20
}

function compresspdf(){
    gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -sOutputFile=$2 $1
}

if (( $+commands[nali] )); then
    function nali-mtr() {
        mtr $@ | nali
    }
    function nali-kdig() {
        kdig $@ | nali
    }
    function nali-dig() {
        dig $@ | nali
    }
fi

function lib_dep() {
    lddtree $1 | grep -E '^    [^ ]+' | cut -d' ' -f7 | xargs pacman -Qo
}

function regex_ipv6() {
    grep -Eo \([[:alnum:]]{2}:\){5}[[:alnum:]]{2} $@
}

function kwin-debug-console() {
    qdbus org.kde.KWin /KWin org.kde.KWin.showDebugConsole
}

function knot-resolver-console() {
    sudo kresc /run/knot-resolver/control/$1
}

# https://github.com/lilydjwg/dotzsh/blob/master/zshrc#L508-520
# delete empty files
function rmempty () {
    for i; do
        [[ -f $i && ! -s $i ]] && rm $i
    done
    return 0
}
# break symbol link
function breakln () {
    for f in $*; do
        tgt=$(readlink "$f")
        unlink "$f"
        cp -rL "$tgt" "$f"
    done
}

# https://maiyang.me/post/2020-08-18-git-commit-history-stat-hour/
function get-someone-commit-time() {
    git log --author="$1" --date=iso | perl -nalE 'if (/^Date:\s+[\d-]{10}\s(\d{2})/) { say $1+0 }' | sort | uniq -c|perl -MList::Util=max -nalE '$h{$F[1]} = $F[0]; }{ $m = max values %h; foreach (0..23) { $h{$_} = 0 if not exists $h{$_} } foreach (sort {$a <=> $b } keys %h) { say sprintf "%02d - %4d %s", $_, $h{$_}, "*"x ($h{$_} / $m * 50); }'
}

function clip2ydcv() {
    if (( $+WAYLAND_DISPLAY )); then
        data="$(wl-paste)"
    else
        data="$(xsel)"
    fi
    ydcv "$data"
}

function clip2qr() {
    if (( $+WAYLAND_DISPLAY )); then
        data="$(wl-paste)"
    else
        data="$(xsel)"
    fi
    echo $data
    echo $data | qrencode -t UTF8
}

# check fcitx5 dbus
function check-fcitx5-dbus() {
    if (( $+commands[qdbus] )); then
        qdbus org.fcitx.Fcitx5 /controller org.fcitx.Fcitx.Controller1.DebugInfo
    elif (( $+commands[dbus-send] )); then
        dbus-send --print-reply --dest=org.fcitx.Fcitx5 /controller org.fcitx.Fcitx.Controller1.DebugInfo
    elif (( $+commands[busctl] )); then
        # TODO: using busctl
        # busctl --user call org.fcitx.Fcitx5 /controller org.fcitx.Fcitx.Controller1.DebugInfo
    fi
}

# https://github.com/lilydjwg/dotzsh/blob/313050449529c84914293283691da1e824d779f5/zshrc#L519
# Change the filename represented by %HH to normal
function mvpc() {
    mv -- $1 "$(echo $1 | ascii2uni -a J | tr '/' '-')"
}
function nocolor() {
    sed -r 's:\x1b\[[0-9;]*[mK]::g;s:[\r\x0f]::g'
}

function weather() {
    # m : metric (SI) (used by default everywhere except US)
    # M : show wind speed in m/s
    # 2 : current weather + today's + tomorrow's forecast
    # A : ignore User-Agent and force ANSI output format (terminal)
    # F : do not show the "Follow" line
    # T : disable color
    local WTTR_PARAMS=('m' 'M' '2' 'F')
    if (( $COLUMNS < 125 )); then
        WTTR_PARAMS+='n'
    fi
    if (( $# > 1 )); then
        lang=$2
    else
        lang=zh
    fi
    if [[ "$TERM" == linux ]]; then
        lang=en
        WTTR_PARAMS+='A'
        WTTR_PARAMS+='T'
    fi
    if [[ ${1:+x} == x ]]; then
        local location="${1// /+}"
    fi

    curl -fGsS --compressed $args "https://wttr.in/${location:-Feicheng}?${(j::)WTTR_PARAMS}&lang=${lang:-${LANG%_*}}"
}

function copy-gpg-db() {
    gpg --export-options export-local-sigs --export ${2:-15F4180E73787863} | \
        ssh $1 gpg --import
    gpg --export-ownertrust | \
        ssh $1 gpg --import-ownertrust
}
function copy-all-gpg-db() {
    gpg --export-options export-local-sigs --export | \
        ssh $1 gpg --import
}
compdef copy-gpg-db=ssh copy-all-gpg-db=ssh

function usbhid-report-descriptor() {
    usbhid-dump "$@" | grep -v : | xxd -r -p | hidrd-convert -o spec
}

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4;
