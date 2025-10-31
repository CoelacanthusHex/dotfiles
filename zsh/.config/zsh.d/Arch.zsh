

# pacman aliases and functions
function Syu() {
    sudo pacman -Syu $@ && sync
    pacman -Qtdq | ifne sudo pacman -Rcs - && sync
    # FIXME: workaround for no packaging
    sudo $commands[pacfiles] -Fy && rehash
}

function Gw() {
    [ -z "$1" ] && echo "usage: Gw <package name> [directory (default to pwd)]: get package file *.pkg.tar.zst/xz from pacman cache" && return 1
    sudo pacman -Sw "$1" && cp /var/cache/pacman/pkg/$1*.pkg.tar.* ${2:-.}
}

# completion for Syu
compdef -e "words[1]=(pacman -Su);service=pacman;((CURRENT+=1));_pacman" Syu Gw

function get-felix-yan-rate() {
    echo "$(echo "scale=1; 100 * $(pacman -Qi $(pacman -Qq) | grep 'Felix Yan' | wc -l) / $(pacman -Qq | wc -l)" | bc) %"
}

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4;
