# Requires colors autoload.
# See termcap(5).

autoload -Uz colors && colors
zmodload zsh/terminfo

# Set up once, and then reuse. This way it supports user overrides after the
# plugin is loaded.
typeset -AHg less_termcap

# bold & blinking mode
less_termcap[mb]="${fg_bold[magenta]}"
less_termcap[md]="${fg_bold[yellow]}"
less_termcap[me]="${reset_color}"
# standout mode
less_termcap[so]="${fg_bold[yellow]}${bg[blue]}"
less_termcap[se]="${terminfo[rmso]}${reset_color}"
# underlining
less_termcap[us]="${terminfo[smul]}${fg_bold[green]}"
less_termcap[ue]="${terminfo[rmul]}${reset_color}"

less_termcap[mr]="${terminfo[rev]}"
less_termcap[mh]="${terminfo[dim]}"
less_termcap[ZN]="${terminfo[ssubm]}"
less_termcap[ZV]="${terminfo[rsubm]}"
less_termcap[ZO]="${terminfo[ssupm]}"
less_termcap[ZW]="${terminfo[rsupm]}"

# Absolute path to this file's directory.
typeset __better_man_pages_dir="${0:A:h}"

function __make_better() {
    local -a environment

    # Convert associative array to plain array of NAME=VALUE items.
    local k v
    for k v in "${(@kv)less_termcap}"; do
        environment+=( "LESS_TERMCAP_${k}=${v}" )
    done

    # Prefer `less` whenever available, since we specifically configured
    # environment for it.
    (( $+commands[less] )) \
        && environment+=( MANPAGER="less -s -M -i -R --mouse" ) \
        || environment+=( MANPAGER="$PAGER" )

    # See ./nroff script.
    if [[ "$OSTYPE" = solaris* ]]; then
        environment+=( PATH="${__colored_man_pages_dir}:$PATH" )
    fi

    command env $environment "$@"
}

# Colorize man and dman/debman (from debian-goodies)
function man \
    dman \
    debman {
    __make_better $0 "$@"
}

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4;
