zsh-defer zinit snippet OMZP::archlinux/archlinux.plugin.zsh


# completion for Syu
compdef -e "words[1]=(pacman -Su);service=pacman;((CURRENT+=1));_pacman" Syu Ge Gc Gw


#软件仓库中重复的软件包
function duppkg4repo () {
  local repo=$1
  [[ -z $repo ]] && { echo >&2 'which repository to examine?'; return 1 }
  local pkgs
  pkgs=$(comm -12 \
    <(pacman -Sl $repo|awk '{print $2}'|sort) \
    <(pacman -Sl|awk -vrepo=$repo '$1 != repo {print $2}'|sort) \
  )
  [[ -z $pkgs ]] && return 0
  LANG=C pacman -Si ${=pkgs} | awk -vself=$repo '/^Repository/{ repo=$3; } /^Name/ && repo != self { printf("%s/%s\n", repo, $3); }'
}

# pacman aliases and functions
if (( $+commands[powerpill] )); then
    function Syu(){
        sudo pacsync pacman -Sy && sudo powerpill -Suw $@ && sudo pacman -Su $@ && sync
        #sudo pacman -Sy && sudo powerpill -Suw $@ && sudo pacman -Su $@ && sync
        pacman -Qtdq | ifne sudo pacman -Rcs - && sync
        sudo pacsync pacman -Fy && sync
    }
fi

# 从爱呼吸老师那里抄的
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

function G() {
    git clone https://git.archlinux.org/svntogit/$1.git/ -b packages/$3 --single-branch $3
    mv "$3"/trunk/* "$3"
    rm -rf "$3"/{repos,trunk,.git}
}

function Gw() {
    [ -z "$1" ] && echo "usage: Gw <package name> [directory (default to pwd)]: get package file *.pkg.tar.zst/xz from pacman cache" && return 1
    sudo pacman -Sw "$1" && cp /var/cache/pacman/pkg/$1*.pkg.tar.* ${2:-.}
}

function Ge() {
    [ -z "$@" ] && echo "usage: $0 <core/extra package name>: get core/extra package PKGBUILD" && return 1
    for i in $@; do
    	G packages core/extra $i
    done
}

function Gc() {
    [ -z "$@" ] && echo "usage: $0 <community package name>: get community package PKGBUILD" && return 1
    for i in $@; do
    	G community community $i
    done
}

function get-felix-yan-rate() {
    echo "$(echo "scale=1; 100 * $(pacman -Qi $(pacman -Qq) | grep Felix | wc -l) / $(pacman -Qq | wc -l)" | bc) %"
}
