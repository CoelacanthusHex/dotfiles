#
# ~/.bashrc
#

# System wide aliases and functions.
[ "$BASH" ] || shopt(){ return ${shopt_def-0}; }
_is_posix(){ shopt -oq posix; }

# Make bash append rather than overwrite the history on disk
# Allows user to edit a failed hist exp.
# Allows user to verify the results of hist exp.
shopt -s histappend histreedit histverify
HISTIGNORE='&:[bf]g:exit'
HISTCONTROL='ignorespace'

# When changing directory small typos can be ignored by bash
# Chdirs into it if command is a dir
# Chdirs into $var if var not found
shopt -s cdspell autocd cdable_vars

# Do not complete when readline buf is empty
shopt -s no_empty_cmd_completion

# Extended glob (3.5.8.1) & find-all-glob with **
shopt -s extglob globstar

# Hashtable the commands!
shopt -s checkhash

# Winsize
shopt -s checkwinsize

# Setup for /bin/ls to support color, the alias is in /etc/bashrc.
if [ "$LS_COLORS" ]; then
    :
elif [ -f "/etc/dircolors" ]; then
    eval "$(dircolors -b /etc/dircolors)"
elif [ -f "$HOME/.dircolors" ] ; then
    eval "$(dircolors -b "$HOME/.dircolors")"
else
    eval "$(dircolors -b)"
fi

# So they can be unset.
# I need someone to help me assign those names properly.
# Those are actually bold colors.
_aosc_bashrc_colors='NORMAL BOLD RED GREEN CYAN IRED YELLOW'
NORMAL='\e[0m'
BOLD='\e[1;37m'
RED='\e[1;31m'
GREEN='\e[1;32m'
CYAN='\e[1;36m'
YELLOW='\e[1;93m'
IRED='\e[0;91m'

if _rc_term_colors="$(tput colors)"; then
    [ "$_rc_term_colors" -le 16 ]
else
    case "$TERM" in (linux|msys|cygwin) true;; (*) false;; esac
fi && YELLOW='\e[1;33m' IRED='\e[0;31m'
unset _rc_term_colors

# if our TERM has no color support, then unset $_aosc_bashrc_colors

# A simple error level reporting function.
# Loaded back to PS1
_ret_prompt() {
    case $? in
        0|130)	# Input C-c, we have to override the \$
            ((EUID)) && echo -n '$' || echo -n '#';;
        127)	# Command not found
            echo -ne '\01\e[1;36m\02?'
            ;;
        *)		# Other errors
            echo -ne '\01'$YELLOW'\02!'
            ;;
    esac
}


[ -f /usr/share/doc/pkgfile/command-not-found.bash ] && source /usr/share/doc/pkgfile/command-not-found.bash

function is-at-least() {
    if command -v vercmp 2>&1 >/dev/null; then
        return $(( $(vercmp "$1" "$2") > 0 ))
    elif command -v dpkg 2>&1 >/dev/null; then
        return $(( $(dpkg --compare-versions "$1" lt "$2") ))
    fi
}

if [[ -x /usr/bin/starship ]] && is-at-least 1.2.0 $(starship --version | head -n 1 | cut -d' ' -f2); then
    export STARSHIP_CONFIG=~/.config/starship.toml
    eval "$(starship init bash)"
else
    ## config for fallback
    if [[ "$EUID" == 0 ]] ; then
        PS1="\[$RED\]\u\[$BOLD\]@\[$NORMAL\]\h [ \W ]\[$RED\] \$(_ret_prompt) \[$NORMAL\]"
    else
        PS1="\[$GREEN\]\u\[$BOLD\]@\[$NORMAL\]\h [ \W ]\[$GREEN\] \$(_ret_prompt) \[$NORMAL\]"
    fi
fi

# https://wiki.archlinux.org/index.php/GnuPG#Configure_pinentry_to_use_the_correct_TTY
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

# A standard alias for which (debianutils vs GNU)
_is_posix || which --version 2>/dev/null | grep -q GNU && alias which='(alias; declare -f) | which -i --read-functions'

# Misc stuffs
FIGNORE='~'
TIMEFORMAT=$'\nreal\t%3lR\t%P%%\nuser\t%3lU\nsys\t%3lS'

# ls
alias ls='ls --color=auto --human-readable --time-style=long-iso'
alias l='ls -AFlh'
alias ll='ls -Flh'
alias la='ls -AF'

# Colors
for c in {e,f,}grep {v,}dir ls; do alias $c="$c --color=auto"; done

[ -x "$(command -v bat)" ] && export BAT_OPTS="--tabs 0"

# space and time efficient cp
alias cp='cp --reflink=auto --sparse=always'

alias nano='nano -w -u'
alias ed='ed -p: -v' # ED for Eununchs hackers.

# cargo install swapview
command -v swapview 2>&1 >/dev/null && alias swapview-continuous='watch -n 1 "swapview | tail -\$((\$LINES - 2)) | cut -b -\$COLUMNS"'

# Vim style alias
alias :e="vim"
alias :q="exit"
alias :w="sync"
alias :x="sync && exit"
alias :wq="sync && exit"
alias :help="man"
alias :h=:help

# Grep colors.
export GREP_COLOR='37;45'           # BSD.
export GREP_COLORS="mt=$GREP_COLOR" # GNU.

GRC_ALIASES=true
[[ -s "/etc/profile.d/grc.sh" ]] && source /etc/profile.d/grc.sh

if [[ ${BASH_ALIASES[colourify]} ]];then
    # default is better
    unalias gcc g++ 2>/dev/null || true
    # bug: https://github.com/garabik/grc/issues/72
    unalias mtr     2>/dev/null || true
    # buffering issues: https://github.com/garabik/grc/issues/25
    unalias ping    2>/dev/null || true
else
    alias diff="diff --color=auto"
    alias ip="ip -c=auto "
fi

unset shopt

# vim: ft=bash sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4;
