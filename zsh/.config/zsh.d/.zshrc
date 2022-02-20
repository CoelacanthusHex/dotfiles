## .zshrc

#[ -f $HOME/.bashrc ] && source $HOME/.bashrc

autoload -Uz is-at-least
if [[ -x /usr/bin/starship ]] && is-at-least 1.2.0 $(starship --version | head -n 1 | cut -d' ' -f2); then
    export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship.toml
    eval "$(starship init zsh)"
elif [[ -r "/usr/share/zsh/functions/Prompts/prompt_pure_setup" ]]; then
    ## config for pure
    autoload -U promptinit; promptinit
    prompt pure
else
    ## config for fallback
    PROMPT='%F{green}%n%f @ %F{magenta}%m%f in %B%F{yellow}%~%f%b -> %(?.%F{green}!.%F{red}?->%?)%f
%F{blue}>>>%f '
fi

source $ZDOTDIR/check.zsh
source $ZDOTDIR/config.zsh
source $ZDOTDIR/completion.zsh
source $ZDOTDIR/function.zsh
source $ZDOTDIR/alias.zsh
source $ZDOTDIR/plugin.zsh
source $ZDOTDIR/keybind.zsh

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
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi

case $OS in
    Arch*)
        source $ZDOTDIR/Arch.zsh
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

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4;
