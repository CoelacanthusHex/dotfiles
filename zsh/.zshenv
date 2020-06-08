
export LANG=en_GB.UTF-8

# Define user direcotires
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

export EDITOR=nvim
export VISUAL="$EDITOR "
export PAGER='less'

export GEM_HOME=$(ruby -e 'print Gem.user_dir')
export MYVIMRC="$HOME/.config/nvim/init.vim"

export GENTOO_MIRRORS=http://mirrors.tuna.tsinghua.edu.cn/gentoo
export GOPROXY=https://goproxy.cn
export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static

#[[ -x /usr/bin/sccache ]] && export RUSTC_WRAPPER='/usr/bin/sccache'

# ignore duplicated path
typeset -U path

# (N-/): do not register if the directory is not exists
#  N: NULL_GLOB option (ignore path if the path does not match the glob)
#  -: follow the symbol links
#  /: ignore files
path=(
    $HOME/.go/bin(N-/)
    $HOME/.cargo/bin(N-/)
    $HOME/.local/bin(N-/)
    $(ruby -e 'print Gem.user_dir')/bin(N-/)
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
    $HOME/.zsh.d/completions(N-/)
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
