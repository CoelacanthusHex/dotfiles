
export LANG=en_GB.UTF-8
export LANGUAGE=en_GB:en
# https://wiki.archlinux.org/title/Locale#LC_TIME:_date_and_time_format
export LC_TIME=en_DK.UTF-8

# Define user direcotires
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

ZDOTDIR="$XDG_CONFIG_HOME/zsh.d"
ZSH_CACHE_HOME="$XDG_CACHE_HOME/zsh"
ZSH_COMPDUMP="$ZSH_CACHE_HOME/zcompdump"
HISTFILE=$ZDOTDIR/zhistory/zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

export EDITOR=vim
export VISUAL="$EDITOR "
export SYSTEMD_EDITOR=$EDITOR
export PAGER='less'
export BROWSER=/usr/bin/xdg-open

# Ripgrep
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME"/ripgreprc

export IPYTHONDIR=$XDG_CONFIG_HOME/ipython
export JUPYTER_CONFIG_DIR=$XDG_CONFIG_HOME/jupyter

# Disable kitty shell integration
unset KITTY_SHELL_INTEGRATION

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
    $XDG_DATA_HOME/cargo/bin(N-/)
    $ZDOTDIR/commands(N-/)
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
    $ZDOTDIR/functions(N-/)
    /usr{/local,}/share/zsh/{site-functions,vendor-completions}(-/N)
    $fpath
)

typeset -U manpath
manpath=(
    $HOME/.local/share/man(N-/)
    $XDG_DATA_HOME/man(N-/)
    $manpath
    /usr/local/share/man(N-/)
    /usr/share/man(N-/)
)

# vim: ft=zsh sw=4 ts=8 sts=4 et
# kate: space-indent on; indent-width 4; syntax zsh;
