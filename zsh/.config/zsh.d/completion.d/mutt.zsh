# Mutt Address Book
[[ -r ~/.config/mutt/muttrc.aliases ]] && zstyle ':completion:*:mutt:*' users ${${${(f)"$(<~/.config/mutt/muttrc.aliases)"}#alias[[:space:]]}%%[[:space:]]*}

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4; 
