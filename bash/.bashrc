#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto --human-readable --time-style=long-iso'

[ -x "$(command -v bat)" ] && alias bat="bat --tabs=0"

PS1='[\u@\h \W]\$ '

[ -f /usr/share/doc/pkgfile/command-not-found.bash ] && source /usr/share/doc/pkgfile/command-not-found.bash

POWERLINE_BINDINGS=/usr/share/powerline/bindings/
if [[ -x /usr/bin/starship ]]; then
    export STARSHIP_CONFIG=~/.config/starship.toml
    eval "$(starship init bash)"
elif [[ -r "$POWERLINE_BINDINGS/bash/powerline.sh" ]]; then
    ## config for powerline
    powerline-daemon -q  # run powerline daemon
    POWERLINE_BASH_CONTINUATION=1
    POWERLINE_BASH_SELECT=1
    source $POWERLINE_BINDINGS/bash/powerline.sh
fi

# https://wiki.archlinux.org/index.php/GnuPG#Configure_pinentry_to_use_the_correct_TTY
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

alias l='ls -al'
