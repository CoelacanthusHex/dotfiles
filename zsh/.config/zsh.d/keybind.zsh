# create a zkbd compatible hash;

# https://github.com/romkatv/zsh4humans/issues/7

autoload -Uz terminfo

# https://github.com/romkatv/zsh4humans/blob/fd101ce997d8434668af517cc159e3ab42c0ff30/fn/-z4h-init-zle#L196
# Delete all existing keymaps and reset to the default state.
bindkey -d
bindkey -e


# first load from terminfo (man terminfo)
typeset -A key=(
    Esc         '\e'
    Space       ' '
    Ctrl+Space  '^ '
    Alt+Space   '\e '
    Home        "${terminfo[khome]}"
    End         "${terminfo[kend]}"
    Insert      "${terminfo[kich1]}"
    Backspace   "${terminfo[kbs]}"
    Delete      "${terminfo[kdch1]}"
    Up          "${terminfo[kcuu1]}"
    Down        "${terminfo[kcud1]}"
    Left        "${terminfo[kcub1]}"
    Right       "${terminfo[kcuf1]}"
    PageUp      "${terminfo[kpp]}"
    PageDown    "${terminfo[knp]}"
    Tab         "${terminfo[ht]}"
    Shift-Tab   "${terminfo[kcbt]}"
    Enter       "${terminfo[kent]}"
    Options     "${terminfo[kopt]}"
    F1          "${terminfo[kf0]}"
    F2          "${terminfo[kf0]}"
    F3          "${terminfo[kf0]}"
    F4          "${terminfo[kf0]}"
    F5          "${terminfo[kf0]}"
    F6          "${terminfo[kf0]}"
    F7          "${terminfo[kf0]}"
    F8          "${terminfo[kf0]}"
    F9          "${terminfo[kf0]}"
    F10         "${terminfo[kf0]}"
    F11         "${terminfo[kf0]}"
    F12         "${terminfo[kf0]}"
    F12         "${terminfo[kf0]}"
)

# these are from terminfo user_cap (man user_caps)
local -A _mods=(Shift               '2'
                Alt                 '3'
                Alt-Shift           '4'
                Ctrl                '5'
                Ctrl-Shift          '6'
                Ctrl-Alt            '7'
                Ctrl-Alt-Shift      '8'
                Meta                '9'
                Meta-Shift          '10'
                Meta-Alt            '11'
                Meta-Alt-Shift      '12'
                Meta-Ctrl           '13'
                Meta-Ctrl-Shift     '14'
                Meta-Ctrl-Alt       '15'
                Meta-Ctrl-Alt-Shift '16'
                )
for k v in $_mods; do
    key[${k}-Up]="${terminfo[kUP${v}]}"
    key[${k}-Down]="${terminfo[kDN${v}]}"
    key[${k}-Left]="${terminfo[kLFT${v}]}"
    key[${k}-Right]="${terminfo[kRIT${v}]}"
    key[${k}-Home]="${terminfo[kHOM${v}]}"
    key[${k}-End]="${terminfo[kEND${v}]}"
    key[${k}-PageUp]="${terminfo[kPRV${v}]}"
    key[${k}-PageDown]="${terminfo[kNXT${v}]}"
    key[${k}-Delete]="${terminfo[kDC${v}]}"
    key[${k}-Insert]="${terminfo[kIC${v}]}"
done

for k in {A..Z} {0..9} '=' '*' '+' '-' '.' '/'; do
    key[${k:u}]="${k:u}"
    key[Ctrl-${k:u}]='^'"${k:u}"
    key[Alt-${k:u}]='\e'"${k:l}"
    key[Ctrl-Alt-${k:u}]='\e'"[6${k:u}"
    key[Alt-Shift-${k:u}]='\e'"${k:u}"
done

# then read any override
[[ -f ${ZDOTDIR:-$HOME}/.zkbd/$TERM-$VENDOR-$OSTYPE ]] && source ${ZDOTDIR:-$HOME}/.zkbd/$TERM-$VENDOR-$OSTYPE

typeset -gA key

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
# See also:
#     http://zsh.sourceforge.net/FAQ/zshfaq03.html#l25
#     https://github.com/fish-shell/fish-shell/issues/2139
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
    autoload -Uz add-zle-hook-widget
    function zle_application_mode_start { echoti smkx }
    function zle_application_mode_stop { echoti rmkx }
    add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
    add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4;
