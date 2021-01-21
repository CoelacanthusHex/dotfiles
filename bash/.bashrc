#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto --human-readable --time-style=long-iso'

[ -x "$(command -v bat)" ] && alias cat="bat --tabs=0"

PS1='[\u@\h \W]\$ '

[ -f /usr/share/doc/pkgfile/command-not-found.bash ] && source /usr/share/doc/pkgfile/command-not-found.bash

POWERLINE_BINDINGS=/usr/share/powerline/bindings/
if [[ -r "$POWERLINE_BINDINGS/bash/powerline.sh" ]]; then
    ## config for powerline
    powerline-daemon -q  # run powerline daemon
    POWERLINE_BASH_CONTINUATION=1
    POWERLINE_BASH_SELECT=1
    source $POWERLINE_BINDINGS/bash/powerline.sh
fi

alias l='ls -al'
