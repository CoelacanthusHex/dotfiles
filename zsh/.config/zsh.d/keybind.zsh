# create a zkbd compatible hash;

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
    Tab                         '^I'
    Space                       ' '
    Ctrl+/                      '^_'
    Ctrl+_                      '^_'
    Ctrl+Space                  '^ '
    Alt+Space                   '^[ '
    Shift+Tab                   '^[[Z'

    Up                          '^[[A'
    Down                        '^[[B'
    Right                       '^[[C'
    Left                        '^[[D'
    Home                        '^[[H'
    End                         '^[[F'
    Insert                      '^[[2~'
    Delete                      '^[[3~'
    PageUp                      '^[[5~'
    PageDown                    '^[[6~'
    Backspace                   '^?'

    Shift+Up                    '^[[1;2A'
    Shift+Down                  '^[[1;2B'
    Shift+Right                 '^[[1;2C'
    Shift+Left                  '^[[1;2D'
    Shift+Home                  '^[[1;2H'
    Shift+End                   '^[[1;2F'
    Shift+Insert                '^[[2;2~'
    Shift+Delete                '^[[3;2~'
    Shift+PageUp                '^[[5;2~'
    Shift+PageDown              '^[[6;2~'
    Shift+Backspace             '^?'

    Alt+Up                      '^[[1;3A'
    Alt+Down                    '^[[1;3B'
    Alt+Right                   '^[[1;3C'
    Alt+Left                    '^[[1;3D'
    Alt+Home                    '^[[1;3H'
    Alt+End                     '^[[1;3F'
    Alt+Insert                  '^[[2;3~'
    Alt+Delete                  '^[[3;3~'
    Alt+PageUp                  '^[[5;3~'
    Alt+PageDown                '^[[6;3~'
    Alt+Backspace               '^[^?'

    Alt+Shift+Up                '^[[1;4A'
    Alt+Shift+Down              '^[[1;4B'
    Alt+Shift+Right             '^[[1;4C'
    Alt+Shift+Left              '^[[1;4D'
    Alt+Shift+Home              '^[[1;4H'
    Alt+Shift+End               '^[[1;4F'
    Alt+Shift+Insert            '^[[2;4~'
    Alt+Shift+Delete            '^[[3;4~'
    Alt+Shift+PageUp            '^[[5;4~'
    Alt+Shift+PageDown          '^[[6;4~'
    Alt+Shift+Backspace         '^[^H'

    Ctrl+Up                     '^[[1;5A'
    Ctrl+Down                   '^[[1;5B'
    Ctrl+Right                  '^[[1;5C'
    Ctrl+Left                   '^[[1;5D'
    Ctrl+Home                   '^[[1;5H'
    Ctrl+End                    '^[[1;5F'
    Ctrl+Insert                 '^[[2;5~'
    Ctrl+Delete                 '^[[3;5~'
    Ctrl+PageUp                 '^[[5;5~'
    Ctrl+PageDown               '^[[6;5~'
    Ctrl+Backspace              '^H'

    Ctrl+Shift+Up               '^[[1;6A'
    Ctrl+Shift+Down             '^[[1;6B'
    Ctrl+Shift+Right            '^[[1;6C'
    Ctrl+Shift+Left             '^[[1;6D'
    Ctrl+Shift+Home             '^[[1;6H'
    Ctrl+Shift+End              '^[[1;6F'
    Ctrl+Shift+Insert           '^[[2;6~'
    Ctrl+Shift+Delete           '^[[3;6~'
    Ctrl+Shift+PageUp           '^[[5;6~'
    Ctrl+Shift+PageDown         '^[[6;6~'
    Ctrl+Shift+Backspace        '^?'

    Ctrl+Alt+Up                 '^[[1;7A'
    Ctrl+Alt+Down               '^[[1;7B'
    Ctrl+Alt+Right              '^[[1;7C'
    Ctrl+Alt+Left               '^[[1;7D'
    Ctrl+Alt+Home               '^[[1;7H'
    Ctrl+Alt+End                '^[[1;7F'
    Ctrl+Alt+Insert             '^[[2;7~'
    Ctrl+Alt+Delete             '^[[3;7~'
    Ctrl+Alt+PageUp             '^[[5;7~'
    Ctrl+Alt+PageDown           '^[[6;7~'
    Ctrl+Alt+Backspace          '^[^H'

    Ctrl+Alt+Shift+Up           '^[[1;8A'
    Ctrl+Alt+Shift+Down         '^[[1;8B'
    Ctrl+Alt+Shift+Right        '^[[1;8C'
    Ctrl+Alt+Shift+Left         '^[[1;8D'
    Ctrl+Alt+Shift+Home         '^[[1;8H'
    Ctrl+Alt+Shift+End          '^[[1;8F'
    Ctrl+Alt+Shift+Insert       '^[[2;8~'
    Ctrl+Alt+Shift+Delete       '^[[3;8~'
    Ctrl+Alt+Shift+PageUp       '^[[5;8~'
    Ctrl+Alt+Shift+PageDown     '^[[6;8~'
    Ctrl+Alt+Shift+Backspace    '^?'

    # Duplicate all Alt bindings with s/Alt/Option/.
    Option+Space                '^[ '

    Option+Up                   '^[[1;3A'
    Option+Down                 '^[[1;3B'
    Option+Right                '^[[1;3C'
    Option+Left                 '^[[1;3D'
    Option+Home                 '^[[1;3H'
    Option+End                  '^[[1;3F'
    Option+Insert               '^[[2;3~'
    Option+Delete               '^[[3;3~'
    Option+PageUp               '^[[5;3~'
    Option+PageDown             '^[[6;3~'
    Option+Backspace            '^[^?'

    Option+Shift+Up             '^[[1;4A'
    Option+Shift+Down           '^[[1;4B'
    Option+Shift+Right          '^[[1;4C'
    Option+Shift+Left           '^[[1;4D'
    Option+Shift+Home           '^[[1;4H'
    Option+Shift+End            '^[[1;4F'
    Option+Shift+Insert         '^[[2;4~'
    Option+Shift+Delete         '^[[3;4~'
    Option+Shift+PageUp         '^[[5;4~'
    Option+Shift+PageDown       '^[[6;4~'
    Option+Shift+Backspace      '^[^H'

    Ctrl+Option+Up              '^[[1;7A'
    Ctrl+Option+Down            '^[[1;7B'
    Ctrl+Option+Right           '^[[1;7C'
    Ctrl+Option+Left            '^[[1;7D'
    Ctrl+Option+Home            '^[[1;7H'
    Ctrl+Option+End             '^[[1;7F'
    Ctrl+Option+Insert          '^[[2;7~'
    Ctrl+Option+Delete          '^[[3;7~'
    Ctrl+Option+PageUp          '^[[5;7~'
    Ctrl+Option+PageDown        '^[[6;7~'
    Ctrl+Option+Backspace       '^[^H'

    Ctrl+Option+Shift+Up        '^[[1;8A'
    Ctrl+Option+Shift+Down      '^[[1;8B'
    Ctrl+Option+Shift+Right     '^[[1;8C'
    Ctrl+Option+Shift+Left      '^[[1;8D'
    Ctrl+Option+Shift+Home      '^[[1;8H'
    Ctrl+Option+Shift+End       '^[[1;8F'
    Ctrl+Option+Shift+Insert    '^[[2;8~'
    Ctrl+Option+Shift+Delete    '^[[3;8~'
    Ctrl+Option+Shift+PageUp    '^[[5;8~'
    Ctrl+Option+Shift+PageDown  '^[[6;8~'
    Ctrl+Option+Shift+Backspace '^?'
)

typeset -grA _key


# setup key accordingly
#[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
#if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
#    function zle-line-init () {
#        printf '%s' "${terminfo[smkx]}"
#    }
#    function zle-line-finish () {
#        printf '%s' "${terminfo[rmkx]}"
#    }
#    zle -N zle-line-init
#    zle -N zle-line-finish
#fi

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4;
