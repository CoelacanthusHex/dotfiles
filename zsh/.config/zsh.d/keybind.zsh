# create a zkbd compatible hash;

typeset -A _key=(
    Tab                         '^I'
    Space                       ' '
    Ctrl+/                      '^_'
    Ctrl+_                      '^_'
    Ctrl+Space                  '^ '
    Alt+Space                   '\e '
    Shift+Tab                   '\e[Z'

    Up                          '\e[A'
    Down                        '\e[B'
    Right                       '\e[C'
    Left                        '\e[D'
    Home                        '\e[H'
    End                         '\e[F'
    Insert                      '\e[2~'
    Delete                      '\e[3~'
    PageUp                      '\e[5~'
    PageDown                    '\e[6~'
    Backspace                   '^?'

    Shift+Up                    '\e[1;2A'
    Shift+Down                  '\e[1;2B'
    Shift+Right                 '\e[1;2C'
    Shift+Left                  '\e[1;2D'
    Shift+Home                  '\e[1;2H'
    Shift+End                   '\e[1;2F'
    Shift+Insert                '\e[2;2~'
    Shift+Delete                '\e[3;2~'
    Shift+PageUp                '\e[5;2~'
    Shift+PageDown              '\e[6;2~'
    Shift+Backspace             '^?'

    Alt+Up                      '\e[1;3A'
    Alt+Down                    '\e[1;3B'
    Alt+Right                   '\e[1;3C'
    Alt+Left                    '\e[1;3D'
    Alt+Home                    '\e[1;3H'
    Alt+End                     '\e[1;3F'
    Alt+Insert                  '\e[2;3~'
    Alt+Delete                  '\e[3;3~'
    Alt+PageUp                  '\e[5;3~'
    Alt+PageDown                '\e[6;3~'
    Alt+Backspace               '\e^?'

    Alt+Shift+Up                '\e[1;4A'
    Alt+Shift+Down              '\e[1;4B'
    Alt+Shift+Right             '\e[1;4C'
    Alt+Shift+Left              '\e[1;4D'
    Alt+Shift+Home              '\e[1;4H'
    Alt+Shift+End               '\e[1;4F'
    Alt+Shift+Insert            '\e[2;4~'
    Alt+Shift+Delete            '\e[3;4~'
    Alt+Shift+PageUp            '\e[5;4~'
    Alt+Shift+PageDown          '\e[6;4~'
    Alt+Shift+Backspace         '\e^H'

    Ctrl+Up                     '\e[1;5A'
    Ctrl+Down                   '\e[1;5B'
    Ctrl+Right                  '\e[1;5C'
    Ctrl+Left                   '\e[1;5D'
    Ctrl+Home                   '\e[1;5H'
    Ctrl+End                    '\e[1;5F'
    Ctrl+Insert                 '\e[2;5~'
    Ctrl+Delete                 '\e[3;5~'
    Ctrl+PageUp                 '\e[5;5~'
    Ctrl+PageDown               '\e[6;5~'
    Ctrl+Backspace              '^H'

    Ctrl+Shift+Up               '\e[1;6A'
    Ctrl+Shift+Down             '\e[1;6B'
    Ctrl+Shift+Right            '\e[1;6C'
    Ctrl+Shift+Left             '\e[1;6D'
    Ctrl+Shift+Home             '\e[1;6H'
    Ctrl+Shift+End              '\e[1;6F'
    Ctrl+Shift+Insert           '\e[2;6~'
    Ctrl+Shift+Delete           '\e[3;6~'
    Ctrl+Shift+PageUp           '\e[5;6~'
    Ctrl+Shift+PageDown         '\e[6;6~'
    Ctrl+Shift+Backspace        '^?'

    Ctrl+Alt+Up                 '\e[1;7A'
    Ctrl+Alt+Down               '\e[1;7B'
    Ctrl+Alt+Right              '\e[1;7C'
    Ctrl+Alt+Left               '\e[1;7D'
    Ctrl+Alt+Home               '\e[1;7H'
    Ctrl+Alt+End                '\e[1;7F'
    Ctrl+Alt+Insert             '\e[2;7~'
    Ctrl+Alt+Delete             '\e[3;7~'
    Ctrl+Alt+PageUp             '\e[5;7~'
    Ctrl+Alt+PageDown           '\e[6;7~'
    Ctrl+Alt+Backspace          '\e^H'

    Ctrl+Alt+Shift+Up           '\e[1;8A'
    Ctrl+Alt+Shift+Down         '\e[1;8B'
    Ctrl+Alt+Shift+Right        '\e[1;8C'
    Ctrl+Alt+Shift+Left         '\e[1;8D'
    Ctrl+Alt+Shift+Home         '\e[1;8H'
    Ctrl+Alt+Shift+End          '\e[1;8F'
    Ctrl+Alt+Shift+Insert       '\e[2;8~'
    Ctrl+Alt+Shift+Delete       '\e[3;8~'
    Ctrl+Alt+Shift+PageUp       '\e[5;8~'
    Ctrl+Alt+Shift+PageDown     '\e[6;8~'
    Ctrl+Alt+Shift+Backspace    '^?'

    # Duplicate all Alt bindings with s/Alt/Option/.
    Option+Space                '\e '

    Option+Up                   '\e[1;3A'
    Option+Down                 '\e[1;3B'
    Option+Right                '\e[1;3C'
    Option+Left                 '\e[1;3D'
    Option+Home                 '\e[1;3H'
    Option+End                  '\e[1;3F'
    Option+Insert               '\e[2;3~'
    Option+Delete               '\e[3;3~'
    Option+PageUp               '\e[5;3~'
    Option+PageDown             '\e[6;3~'
    Option+Backspace            '\e^?'

    Option+Shift+Up             '\e[1;4A'
    Option+Shift+Down           '\e[1;4B'
    Option+Shift+Right          '\e[1;4C'
    Option+Shift+Left           '\e[1;4D'
    Option+Shift+Home           '\e[1;4H'
    Option+Shift+End            '\e[1;4F'
    Option+Shift+Insert         '\e[2;4~'
    Option+Shift+Delete         '\e[3;4~'
    Option+Shift+PageUp         '\e[5;4~'
    Option+Shift+PageDown       '\e[6;4~'
    Option+Shift+Backspace      '\e^H'

    Ctrl+Option+Up              '\e[1;7A'
    Ctrl+Option+Down            '\e[1;7B'
    Ctrl+Option+Right           '\e[1;7C'
    Ctrl+Option+Left            '\e[1;7D'
    Ctrl+Option+Home            '\e[1;7H'
    Ctrl+Option+End             '\e[1;7F'
    Ctrl+Option+Insert          '\e[2;7~'
    Ctrl+Option+Delete          '\e[3;7~'
    Ctrl+Option+PageUp          '\e[5;7~'
    Ctrl+Option+PageDown        '\e[6;7~'
    Ctrl+Option+Backspace       '\e^H'

    Ctrl+Option+Shift+Up        '\e[1;8A'
    Ctrl+Option+Shift+Down      '\e[1;8B'
    Ctrl+Option+Shift+Right     '\e[1;8C'
    Ctrl+Option+Shift+Left      '\e[1;8D'
    Ctrl+Option+Shift+Home      '\e[1;8H'
    Ctrl+Option+Shift+End       '\e[1;8F'
    Ctrl+Option+Shift+Insert    '\e[2;8~'
    Ctrl+Option+Shift+Delete    '\e[3;8~'
    Ctrl+Option+Shift+PageUp    '\e[5;8~'
    Ctrl+Option+Shift+PageDown  '\e[6;8~'
    Ctrl+Option+Shift+Backspace '^?'
)
typeset -grA _key

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4;
