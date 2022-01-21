## .zshrc

export HISTFILE=$XDG_CONFIG_HOME/zsh.d/zhistory/zsh_history

HISTSIZE=1000000
SAVEHIST=1000000

ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump"

#[ -f $HOME/.bashrc ] && source $HOME/.bashrc

autoload -Uz is-at-least
if [[ -x /usr/bin/starship ]] && is-at-least 1.2.0 $(starship --version | head -n 1 | cut -d' ' -f2); then
    export STARSHIP_CONFIG=~/.config/starship.toml
    eval "$(starship init zsh)"
elif [[ -r "/usr/share/zsh/functions/Prompts/prompt_pure_setup" ]]; then
    ## config for pure
    autoload -U promptinit; promptinit
    prompt pure
elif [[ -r "$POWERLINE_BINDINGS/zsh/powerline.zsh" ]]; then
    ## config for fallback
    PROMPT='%F{green}%n%f @ %F{magenta}%m%f in %B%F{yellow}%~%f%b -> %(?.%F{green}!.%F{red}?->%?)%f
%F{blue}>>>%f '
fi

source $XDG_CONFIG_HOME/zsh.d/check.zsh
source $XDG_CONFIG_HOME/zsh.d/config.zsh
source $XDG_CONFIG_HOME/zsh.d/completion.zsh
source $XDG_CONFIG_HOME/zsh.d/function.zsh
source $XDG_CONFIG_HOME/zsh.d/alias.zsh
source $XDG_CONFIG_HOME/zsh.d/plugin.zsh
source $XDG_CONFIG_HOME/zsh.d/keybind.zsh
source $XDG_CONFIG_HOME/zsh.d/Arch.zsh

# Load user config.
if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi

# https://wiki.archlinux.org/index.php/GnuPG#Configure_pinentry_to_use_the_correct_TTY
# it's much faster than the commonly used `export GPG_TTY=$(tty)`
export GPG_TTY=$TTY
gpg-connect-agent updatestartuptty /bye >/dev/null

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4;
