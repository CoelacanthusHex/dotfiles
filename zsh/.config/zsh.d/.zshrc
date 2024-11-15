## .zshrc

autoload -Uz is-at-least
is-at-least 5.1 || {
    _cfg_error "This profile need Zsh 5.1 and above to work properly!"
}

_cfg_info() {
    print -P "%F{green}[INFO]%f $1"
}

_cfg_warning() {
    print -P "%F{yellow}[WARN]%f $1"
}

_cfg_error() {
    print -P "%F{red}[ERROR]%f $1"
}

() {
    if (( $+commands[locale] )); then
        setopt localoptions extended_glob
        local -a available
        local -A locales
        local locale l
        locales=(
            "LANG" "en_US C"
            "LC_MESSAGES" "en_US C" # Just in english
            "LC_TIME" "en_DK C" # ISO 8601
            "LC_NUMERIC" "en_US C" # Split by 3, use . as separator
            "LC_PAPER" "en_GB C" # A4
            "LC_MEASUREMENT" "en_GB C" # SI
            "LC_COLLATE" "C" # Consistent with programming
        )
        available=("${(f)$(locale -a)}")
        # https://blog.xen0n.name/posts/tinkering/glibc-utf-8-locale-misery/
        available=(${(@)available//utf8/UTF-8})
        for locale in ${(k)locales}; do
            export $locale=C        # default value
            for l in $=locales[$locale]; do
                for charset in UTF-8; do
                    if (( ${available[(i)$l.$charset]} <= ${#available} )); then
                        export $locale=$l.$charset
                        break 2
                    fi
                done
            done
        done
        # https://wiki.archlinux.org/title/Locale#LANGUAGE:_fallback_locales
        export LANGUAGE=en_US:en:C
    fi
}

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
export NALI_HOME="$XDG_CONFIG_HOME"/nali

# https://docs.python.org/3/using/cmdline.html#envvar-PYTHONSAFEPATH
# FIXME: disable for too many things broken
#export PYTHONSAFEPATH=1

# replacing ssh-agent with gpg-agent
# https://wiki.archlinux.org/index.php/GnuPG#SSH_agent
#unset SSH_AGENT_PID=""
#export SSH_AUTH_SOCCK=${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh

# Disable kitty shell integration
unset KITTY_SHELL_INTEGRATION

export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static

export REPO_URL=https://mirrors.bfsu.edu.cn/git/git-repo
export USE_CCACHE=1

# FIXME: workaround for cargo crates
# [1]: https://github.com/ustclug/discussions/issues/294
# [2]: https://mirrors.ustc.edu.cn/help/crates.io-index.html
# We use BFSU now
#export CARGO_HTTP_MULTIPLEXING=false

export CARGO_UNSTABLE_SPARSE_REGISTRY=true

#export WINEARCH=win32

#export SCCACHE_DIR="/var/cache/sccache"
[[ -x /usr/bin/sccache ]] && export RUSTC_WRAPPER="/usr/bin/sccache"

disable_p10k=0
disable_starship=0
disable_pure=1
disable_async_prompt=0

source $ZDOTDIR/plugins/zsh-smartcache/zsh-smartcache.plugin.zsh
source $ZDOTDIR/keybind.zsh
source $ZDOTDIR/config.zsh
source $ZDOTDIR/prompt.zsh
source $ZDOTDIR/completion.zsh
source $ZDOTDIR/function.zsh
source $ZDOTDIR/alias.zsh
source $ZDOTDIR/plugin.zsh

if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    OS=Debian
    VER=$(cat /etc/debian_version)
elif (( ${(L)OSTYPE[(I)linux-android]} )); then
    OS=Termux
    VER=$(uname -r)
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi

case $OS in
    Arch*)
        source $ZDOTDIR/Arch.zsh
    ;;
    Termux*)
        source $ZDOTDIR/Termux.zsh
    ;;
    *)
        : # do nothing now
    ;;

esac

unset OS
unset VER

# Load user config.
if [[ -f $ZDOTDIR/.zshrc.local ]]; then
    source $ZDOTDIR/.zshrc.local
fi

# https://wiki.archlinux.org/index.php/GnuPG#Configure_pinentry_to_use_the_correct_TTY
# it's much faster than the commonly used `export GPG_TTY=$(tty)`
export GPG_TTY=$TTY

_prompt.p10k.post_hook

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4; syntax zsh;
