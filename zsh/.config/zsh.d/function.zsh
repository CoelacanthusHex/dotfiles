# zsh_stats from oh-my-zsh https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/functions.zsh
function zsh_stats() {
    fc -l 1 | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n20
}

function compresspdf(){
    gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -sOutputFile=$2 $1
}

function wifi(){
    [ -z "$1" -o -z "$2" -o -z "$3" ] && echo -e "usage: wifi <interface> <ssid> <password>: connect to <ssid> at <interface> using <password>" && return 1
    sudo bash -c "wpa_passphrase $2 $3 | wpa_supplicant -Dwext -i$1 -c/dev/stdin &"
    sleep 5
    sudo dhcpcd $1
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

# 图像压缩
function opt_png(){
    fd '.*\.png' $2 | parallel --bar optipng $1 {}
}

function opt_jpg(){
    fd '.*\.jpg' $1 | parallel --bar jpegoptim {}
}

function png2webp() {
    fd '.*\.png' $1 --exec cwebp -lossless {} -o {.}.webp ;
}

function jpg2webp() {
    fd '.*\.jpg' $1 --exec cwebp {} -o {.}.webp ;
}

function encode64() {
    if [[ $# -eq 0 ]]; then
        cat | base64
    else
        printf '%s' $1 | base64
    fi
}

function decode64() {
    if [[ $# -eq 0 ]]; then
        cat | base64 --decode
    else
        printf '%s' $1 | base64 --decode
    fi
}

alias e64=encode64
alias d64=decode64

function lib_dep() {
    lddtree $1 | grep -E '^    [^ ]+' | cut -d' ' -f7 | xargs pacman -Qo
}

function regex_ipv6() {
    grep -Eo \([[:alnum:]]{2}:\){5}[[:alnum:]]{2} $@
}

function kwin-debug-console() {
    qdbus org.kde.KWin /KWin org.kde.KWin.showDebugConsole
}
# https://github.com/lilydjwg/dotzsh/blob/master/zshrc#L508-520
function rmempty () { #删除空文件 {{{2
    for i; do
        [[ -f $i && ! -s $i ]] && rm $i
    done
    return 0
}

function breakln () { #断掉软链接 {{{2
    for f in $*; do
        tgt=$(readlink "$f")
        unlink "$f"
        cp -rL "$tgt" "$f"
    done
}

function extract() {
    setopt localoptions noautopushd

    local remove_archive
    local success
    local extract_dir
    local file
    local full_path

    if (( $# == 0 )); then
        printf "Usage: extract [-option] [file ...]\n\nOptions:\n\t-r, --remove    Remove archive after unpacking."
    fi

    local remove_archive=1
    if [[ "$1" == "-r" ]] || [[ "$1" == "--remove" ]]; then
        remove_archive=0
        shift
    fi

    local pwd="$PWD"
    while (( $# > 0 )); do
        if [[ ! -f "$1" ]]; then
            echo "extract: '$1' is not a valid file" >&2
            shift
            continue
        fi

        success=0
        extract_dir="${1:t:r}"
        file="$1"
        full_path="${1:A}"
        case "${file:l}" in
            (*.tar.gz|*.tgz) (( $+commands[pigz] )) && { pigz -dc "$file" | tar xv } || tar zxvf "$file" ;;
            (*.tar.bz2|*.tbz|*.tbz2) tar xvjf "$file" ;;
            (*.tar.xz|*.txz)
                tar --xz --help &> /dev/null \
                && tar --xz -xvf "$file" \
                || xzcat "$file" | tar xvf - ;;
            (*.tar.zma|*.tlz)
                tar --lzma --help &> /dev/null \
                && tar --lzma -xvf "$file" \
                || lzcat "$file" | tar xvf - ;;
            (*.tar.zst|*.tzst)
                tar --zstd --help &> /dev/null \
                && tar --zstd -xvf "$file" \
                || zstdcat "$file" | tar xvf - ;;
            (*.tar.lz) (( $+commands[lzip] )) && tar xvf "$file" ;;
            (*.tar.lz4) lz4 -c -d "$file" | tar xvf - ;;
            (*.tar.lrz) (( $+commands[lrzuntar] )) && lrzuntar "$file" ;;
            (*.tar|*.cbt) tar xvf "$file" ;;
            (*.gz) (( $+commands[pigz] )) && pigz -dk "$file" || gunzip -k "$file" ;;
            (*.bz2) bunzip2 "$file" ;;
            (*.xz) unxz "$file" ;;
            (*.lrz) (( $+commands[lrunzip] )) && lrunzip "$file" ;;
            (*.lz4) lz4 -d "$file" ;;
            (*.lzma) unlzma "$file" ;;
            (*.z|*.Z) uncompress "$file" ;;
            (*.zip|*.war|*.jar|*.ear|*.sublime-package|*.ipa|*.ipsw|*.xpi|*.apk|*.aar|*.whl|*.cbz|*.epub|*.maff) unzip "$file" -d $extract_dir ;;
            (*.rar|*.cbr) unrar x -ad "$file" ;;
            (*.rpm) command mkdir "$extract_dir" && builtin cd -q "$extract_dir" \
                && rpm2cpio "$full_path" | cpio --quiet -id ;;
            (*.7z|*.chm|*cb7) 7za x "$file" ;;
            (*.deb)
                command mkdir -p "$extract_dir/control" "$extract_dir/data"
                builtin cd -q "$extract_dir"; ar vx "$full_path" > /dev/null
                builtin cd -q control; tar xzvf ../control.tar.gz
                builtin cd -q ../data; extract ../data.tar.*
                builtin cd -q ..; command rm *.tar.* debian-binary
            ;;
            (*.zst) unzstd "$file" ;;
            (*.cab|*.exe) cabextract -d "$extract_dir" "$file" ;;
            (*.cpio) cpio -idMvF "$file" ;;
            (*.cba|*.ace) unace x "$file" ;;
            (*.zpaq) zpaq x "$file" ;;
            (*.arc) arc e "$file" ;;
            (*.zlib)  zlib-flate -uncompress < "$file" > "${file%.*zlib}" ;;
            (*)
                echo "extract: '$1' cannot be extracted" >&2
                success=1
            ;;
        esac

        (( success = $success > 0 ? $success : $? ))
        (( $success == 0 && $remove_archive == 0 )) && rm "$full_path"
        shift

        # Go back to original working directory in case we ran cd previously
        builtin cd -q "$pwd"
    done
}

alias x=extract

# https://maiyang.me/post/2020-08-18-git-commit-history-stat-hour/
function get-someone-commit-time() {
    git log --author="$1" --date=iso | perl -nalE 'if (/^Date:\s+[\d-]{10}\s(\d{2})/) { say $1+0 }' | sort | uniq -c|perl -MList::Util=max -nalE '$h{$F[1]} = $F[0]; }{ $m = max values %h; foreach (0..23) { $h{$_} = 0 if not exists $h{$_} } foreach (sort {$a <=> $b } keys %h) { say sprintf "%02d - %4d %s", $_, $h{$_}, "*"x ($h{$_} / $m * 50); }'
}

function foreground-last-job () {
    if (( ${#jobstates} )); then
        zle .push-input
        [[ -o hist_ignore_space ]] && BUFFER=' ' || BUFFER=''
        BUFFER="${BUFFER}fg"
        zle .accept-line
    else
        zle -M 'No background jobs. Doing nothing.'
    fi
}
zle -N foreground-last-job

bindkey "$_key[Ctrl+Z]" foreground-last-job
bindkey -M emacs "$_key[Ctrl+Z]" foreground-last-job
bindkey -M viins "$_key[Ctrl+Z]" foreground-last-job

# add a command line to the shells history without executing it
function commit-to-history () {
    print -s ${(z)BUFFER}
    zle send-break
}
zle -N commit-to-history
# bindkey -M viins "^x^h" commit-to-history
# bindkey -M emacs "^x^h" commit-to-history

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

# https://github.com/lilydjwg/dotzsh/blob/313050449529c84914293283691da1e824d779f5/zshrc#L445
(( $+commands[mpv] )) && compdef mpv=mpv
function mpv() {
    if [[ -z $WAYLAND_DISPLAY && -n $DISPLAY ]]; then
        # or too big
        command mpv --no-hidpi-window-scale "$@"
    else
        # or blurry
        command mpv "$@"
    fi
}

# https://github.com/lilydjwg/dotzsh/blob/313050449529c84914293283691da1e824d779f5/zshrc#L519
# 将以 %HH 表示的文件名改正常
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
    if (( $(tput cols) < 125 )); then
        WTTR_PARAMS+='n'
    fi
    if (( $# > 1 )); then
        lang=$2
    else
        lang=zh
    fi
    if (( $_in_linux_tty == 1 )); then
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
compdef  copy-gpg-db=ssh copy-all-gpg-db=ssh

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4;
