## Zsh env file

# Define user direcotires
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
    
# Other UTF-8 locales on Linux give weird whitespace sorting.
export LC_COLLATE=C.UTF-8

ZDOTDIR="$XDG_CONFIG_HOME/zsh.d"

# ignore duplicated path
typeset -U path

# (N-/): do not register if the directory is not exists
#  N: NULL_GLOB option (ignore path if the path does not match the glob)
#  -: follow the symbol links
#  /: ignore files
path=(
    $HOME/.go/bin(N-/)
    $XDG_DATA_HOME/go/bin(N-/)
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
    $HOME/project/qt/qt5/qtrepotools/bin(N-/)
    $path
)

typeset -U fpath
fpath=(
    $ZDOTDIR/completions(N-/)
    $ZDOTDIR/functions(N-/)
    /usr{/local,}/share/zsh/{site-functions,vendor-completions}(/-N)
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

export DEBUGINFOD_PROGRESS=1

# vim: ft=zsh sw=4 ts=8 sts=4 et
# kate: space-indent on; indent-width 4; syntax zsh;
