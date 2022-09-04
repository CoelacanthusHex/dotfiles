# create a zkbd compatible hash;

autoload -Uz terminfo



# https://github.com/romkatv/zsh4humans/blob/fd101ce997d8434668af517cc159e3ab42c0ff30/fn/-z4h-init-zle#L196
# Delete all existing keymaps and reset to the default state.
bindkey -d
bindkey -e

local keymap
for keymap in emacs viins vicmd; do
    # If NumLock is off, translate keys to make them appear the same as with NumLock on.
    bindkey -M $keymap -s '^[OM'     '^M'      # enter
    bindkey -M $keymap -s '^[OX'     '='
    bindkey -M $keymap -s '^[Oj'     '*'
    bindkey -M $keymap -s '^[Ok'     '+'
    bindkey -M $keymap -s '^[Ol'     '+'
    bindkey -M $keymap -s '^[Om'     '-'
    bindkey -M $keymap -s '^[On'     '.'
    bindkey -M $keymap -s '^[Oo'     '/'
    bindkey -M $keymap -s '^[Op'     '0'
    bindkey -M $keymap -s '^[Oq'     '1'
    bindkey -M $keymap -s '^[Or'     '2'
    bindkey -M $keymap -s '^[Os'     '3'
    bindkey -M $keymap -s '^[Ot'     '4'
    bindkey -M $keymap -s '^[Ou'     '5'
    bindkey -M $keymap -s '^[Ov'     '6'
    bindkey -M $keymap -s '^[Ow'     '7'
    bindkey -M $keymap -s '^[Ox'     '8'
    bindkey -M $keymap -s '^[Oy'     '9'

    # If someone switches our terminal to application mode (smkx), translate keys to make
    # them appear the same as in raw mode (rmkx).
    bindkey -M $keymap -s '^[OA'     '^[[A'    # up
    bindkey -M $keymap -s '^[OB'     '^[[B'    # down
    bindkey -M $keymap -s '^[OD'     '^[[D'    # left
    bindkey -M $keymap -s '^[OC'     '^[[C'    # right
    bindkey -M $keymap -s '^[OH'     '^[[H'    # home
    bindkey -M $keymap -s '^[OF'     '^[[F'    # end

    # TTY sends different key codes. Translate them to xterm equivalents.
    # Missing: {ctrl,alt,shift}+{up,down,left,right,home,end}, {ctrl,alt}+delete.
    bindkey -M $keymap -s '^[[1~'    '^[[H'    # home
    bindkey -M $keymap -s '^[[4~'    '^[[F'    # end

    # Urxvt sends different key codes. Translate them to xterm equivalents.
    bindkey -M $keymap -s '^[[7~'    '^[[H'    # home
    bindkey -M $keymap -s '^[[8~'    '^[[F'    # end
    bindkey -M $keymap -s '^[Oa'     '^[[1;5A' # ctrl+up
    bindkey -M $keymap -s '^[Ob'     '^[[1;5B' # ctrl+down
    bindkey -M $keymap -s '^[Od'     '^[[1;5D' # ctrl+left
    bindkey -M $keymap -s '^[Oc'     '^[[1;5C' # ctrl+right
    bindkey -M $keymap -s '^[[7\^'   '^[[1;5H' # ctrl+home
    bindkey -M $keymap -s '^[[8\^'   '^[[1;5F' # ctrl+end
    bindkey -M $keymap -s '^[[3\^'   '^[[3;5~' # ctrl+delete
    bindkey -M $keymap -s '^[^[[A'   '^[[1;3A' # alt+up
    bindkey -M $keymap -s '^[^[[B'   '^[[1;3B' # alt+down
    bindkey -M $keymap -s '^[^[[D'   '^[[1;3D' # alt+left
    bindkey -M $keymap -s '^[^[[C'   '^[[1;3C' # alt+right
    bindkey -M $keymap -s '^[^[[7~'  '^[[1;3H' # alt+home
    bindkey -M $keymap -s '^[^[[8~'  '^[[1;3F' # alt+end
    bindkey -M $keymap -s '^[^[[3~'  '^[[3;3~' # alt+delete
    bindkey -M $keymap -s '^[[a'     '^[[1;2A' # shift+up
    bindkey -M $keymap -s '^[[b'     '^[[1;2B' # shift+down
    bindkey -M $keymap -s '^[[d'     '^[[1;2D' # shift+left
    bindkey -M $keymap -s '^[[c'     '^[[1;2C' # shift+right
    bindkey -M $keymap -s '^[[7$'    '^[[1;2H' # shift+home
    bindkey -M $keymap -s '^[[8$'    '^[[1;2F' # shift+end

    # Tmux sends different key codes. Translate them to xterm equivalents.
    bindkey -M $keymap -s '^[[1~'    '^[[H'    # home
    bindkey -M $keymap -s '^[[4~'    '^[[F'    # end
    bindkey -M $keymap -s '^[^[[A'   '^[[1;3A' # alt+up
    bindkey -M $keymap -s '^[^[[B'   '^[[1;3B' # alt+down
    bindkey -M $keymap -s '^[^[[D'   '^[[1;3D' # alt+left
    bindkey -M $keymap -s '^[^[[C'   '^[[1;3C' # alt+right
    bindkey -M $keymap -s '^[^[[1~'  '^[[1;3H' # alt+home
    bindkey -M $keymap -s '^[^[[4~'  '^[[1;3F' # alt+end
    bindkey -M $keymap -s '^[^[[3~'  '^[[3;3~' # alt+delete

    # iTerm2 sends different key codes. Translate them to xterm equivalents.
    # Missing (depending on settings): ctrl+{up,down,left,right}, {ctrl,alt}+{delete,backspace}.
    bindkey -M $keymap -s '^[^[[A'   '^[[1;3A' # alt+up
    bindkey -M $keymap -s '^[^[[B'   '^[[1;3B' # alt+down
    bindkey -M $keymap -s '^[^[[D'   '^[[1;3D' # alt+left
    bindkey -M $keymap -s '^[^[[C'   '^[[1;3C' # alt+right
    bindkey -M $keymap -s '^[[1;9A'  '^[[1;3A' # alt+up
    bindkey -M $keymap -s '^[[1;9B'  '^[[1;3B' # alt+down
    bindkey -M $keymap -s '^[[1;9D'  '^[[1;3D' # alt+left
    bindkey -M $keymap -s '^[[1;9C'  '^[[1;3C' # alt+right
    bindkey -M $keymap -s '^[[1;9H'  '^[[1;3H' # alt+home
    bindkey -M $keymap -s '^[[1;9F'  '^[[1;3F' # alt+end

    # TODO: Add missing translations.
done

typeset -A _key=(
    Esc                         '\e'
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
    Ctrl+Alt+-                  '\e^_'

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

for k in {A..Z}; do
    _key[Ctrl+${k:u}]='^'"${k:u}"
    _key[Alt+${k:u}]='\e'"${k:l}"
    _key[Ctrl+Alt+${k:u}]='\e'"[6${k:u}"
    _key[Alt+Shift+${k:u}]='\e'"${k:u}"
done

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
