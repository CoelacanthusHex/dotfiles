
export LANG=en_GB.UTF-8
export LANGUAGE=en_GB

# Define user direcotires
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

export EDITOR=vim
export VISUAL="$EDITOR "
export SYSTEMD_EDITOR=$EDITOR
export PAGER='less'

# Workaround: GUI app like KMail need pinentry-qt but we need pinentry-curse in the terminal
# https://wiki.gentoo.org/wiki/GnuPG#Changing_pinentry_for_SSH_logins
# It's useless but
#export PINENTRY_USER_DATA="USE_CURSES=1"

export MAIL=$HOME/.mail/

#export GENTOO_MIRRORS="https://mirrors.bfsu.edu.cn/gentoo"
#export EPREFIX=/home/coelacanthus/Data/gentoo/prefix
export GO111MODULE=on
export GOPROXY=https://goproxy.cn
export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static

# FIXME: workaround for cargo crates
# [1]: https://github.com/ustclug/discussions/issues/294
# [2]: https://mirrors.ustc.edu.cn/help/crates.io-index.html
export CARGO_HTTP_MULTIPLEXING=false

#export WINEARCH=win32

#export SCCACHE_DIR="/var/cache/sccache"
[[ -x /usr/bin/sccache ]] && export RUSTC_WRAPPER="/usr/bin/sccache"

# ignore duplicated path
typeset -U path

# (N-/): do not register if the directory is not exists
#  N: NULL_GLOB option (ignore path if the path does not match the glob)
#  -: follow the symbol links
#  /: ignore files
path=(
    $HOME/.go/bin(N-/)
    $HOME/.cargo/bin(N-/)
    $XDG_CONFIG_HOME/zsh.d/functions(N-/)
    $HOME/.local/bin(N-/)
    /usr/local/bin(N-/)
    /usr/bin(N-/)
    /bin(N-/)
    /usr/local/sbin(N-/)
    /usr/sbin(N-/)
    /sbin(N-/)
    $path
)

typeset -U fpath
fpath=(
    $ZDOTDIR/completions(N-/)
    $XDG_CONFIG_HOME/zsh.d/completions(N-/)
    $fpath
)

typeset -U manpath
manpath=(
    $HOME/.local/share/man(N-/)
    XDG_DATA_HOME/man(N-/)
    $manpath
    /usr/local/share/man(N-/)
    /usr/share/man(N-/)
)
