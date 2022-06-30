## Zsh env file and init file

_cfg_info() {
    print -P "%F{green}[INFO]%f $1"
}

_cfg_warning() {
    print -P "%F{yellow}[WARN]%f $1"
}

_cfg_error() {
    print -P "%F{red}[ERROR]%f $1"
}

if locale --all-locales | grep en_DK; then
    export LANG=en_GB.UTF-8
else
    for la in en_US C; do
        if locale --all-locales | grep $la; then
            _cfg_warning "Locale en_GB is not supported! Fallback LANG to $la."
            export LANG=$la.UTF-8
            break
        fi
    done
fi
export LANGUAGE=en_GB:en_US:en
if locale --all-locales | grep en_DK; then
    # https://wiki.archlinux.org/title/Locale#LC_TIME:_date_and_time_format
    export LC_TIME=en_DK.UTF-8
else
    for la in en_GB en_US C; do
        if locale --all-locales | grep $la; then
            _cfg_warning "Locale en_DK is not supported! Fallback LC_TIME to $la."
            export LC_TIME=$la.UTF-8
            break
        fi
    done
fi

if (( ${OSTYPE:l}[(I)linux] )); then
    # Define user direcotires
    export XDG_CONFIG_HOME="$HOME/.config"
    export XDG_CACHE_HOME="$HOME/.cache"
    export XDG_DATA_HOME="$HOME/.local/share"
elif (( ${OSTYPE:l}[(I)mac] )); then
    _cfg_warning "Operating System $OSTYPE is not implemented!"
elif (( ${OSTYPE:l}[(I)win] )); then
    _cfg_warning "Operating System $OSTYPE is not implemented!"
else
    _cfg_warning "Operating System $OSTYPE is not supported!"
fi

ZDOTDIR="$XDG_CONFIG_HOME/zsh.d"
ZSH_CACHE_HOME="$XDG_CACHE_HOME/zsh"
ZSH_COMPDUMP="$ZSH_CACHE_HOME/zcompdump"

HISTFILE="$ZDOTDIR/zhistory/zsh_history"
HISTSIZE=1000000
SAVEHIST=1000000

export EDITOR=vim
export VISUAL="$EDITOR "
export SYSTEMD_EDITOR=$EDITOR
export PAGER='less'
export BROWSER=/usr/bin/xdg-open

export MAIL="$HOME/Mail"

# Ripgrep
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME"/ripgreprc
export NALI_HOME=$XDG_CONFIG_HOME/nali

export IPYTHONDIR=$XDG_CONFIG_HOME/ipython
export JUPYTER_CONFIG_DIR=$XDG_CONFIG_HOME/jupyter

# Disable kitty shell integration
unset KITTY_SHELL_INTEGRATION

export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static

export REPO_URL=https://mirrors.bfsu.edu.cn/git/git-repo
export USE_CCACHE=1

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
    $HOME/Data/workspace/project/qt/qt5/qtrepotools/bin(N-/)
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

typeset -T DEBUGINFOD_URLS debuginfod_urls ' '
debuginfod_urls=(
    $debuginfod_urls
    https://debuginfod.archlinux.org
    https://repo.archlinuxcn.org
    https://debuginfod.debian.net
    https://debuginfod.fedoraproject.org
    https://debuginfod.centos.org
    https://debuginfod.elfutils.org
)
export DEBUGINFOD_PROGRESS=1

# vim: ft=zsh sw=4 ts=8 sts=4 et
# kate: space-indent on; indent-width 4; syntax zsh;
