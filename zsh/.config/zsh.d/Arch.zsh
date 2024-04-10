

# pacman aliases and functions
function Syu() {
    sudo pacman -Syu $@ && sync
    pacman -Qtdq | ifne sudo pacman -Rcs - && sync
    sudo pacman -Fy && sync && rehash
}

# https://github.com/farseerfc/dotfiles/blob/master/zsh/.bashrc#L100-L123

# pacman aliases and functions
alias Rcs="sudo pacman -Rcs"
alias Ss="pacman -Ss"
alias Si="pacman -Si"
alias Sl="pacman -Sl"
alias Sg="pacman -Sg"
alias Qs="pacman -Qs"
alias Qi="pacman -Qi"
alias Qo="pacman -Qo"
alias Ql="pacman -Ql"
alias Qlp="pacman -Qlp"
alias Qm="pacman -Qm"
alias Qn="pacman -Qn"
alias U="sudo pacman -U"
alias F="pacman -F"
alias Fo="pacman -F"
alias Fs="pacman -F"
alias Fl="pacman -Fl"
alias Fy="sudo pacman -Fy"
alias Sy="sudo pacman -Sy"
alias Ssa="paru -Ssa"
alias Sas="paru -Ssa"
alias Sia="paru -Sai"
alias Sai="paru -Sai"

function Ga() {
    [ -z "$1" ] && echo "usage: Ga <aur package name>: get AUR package PKGBUILD" && return 1
    TMPDIR=$(mktemp -d)
    git clone aur@aur.archlinux.org:"$1".git "$TMPDIR"
    rm -rf "$TMPDIR"/.git
    mkdir -p "$1"
    cp -r -i "$TMPDIR"/* "$1"/
    rm -rf "$TMPDIR"
}


function Gw() {
    [ -z "$1" ] && echo "usage: Gw <package name> [directory (default to pwd)]: get package file *.pkg.tar.zst/xz from pacman cache" && return 1
    sudo pacman -Sw "$1" && cp /var/cache/pacman/pkg/$1*.pkg.tar.* ${2:-.}
}

# completion for Syu
compdef -e "words[1]=(pacman -Su);service=pacman;((CURRENT+=1));_pacman" Syu Ge Gc Gw

function get-felix-yan-rate() {
    echo "$(echo "scale=1; 100 * $(pacman -Qi $(pacman -Qq) | grep 'Felix Yan' | wc -l) / $(pacman -Qq | wc -l)" | bc) %"
}

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4;
