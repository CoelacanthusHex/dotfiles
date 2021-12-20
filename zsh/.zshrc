## .zshrc

# 确定环境 {{{1
OS=${$(uname)%_*}
LSB_DISTRIBUTOR=`lsb_release -i -s`
if [[ $OS == "CYGWIN" || $OS == "MSYS" ]]; then
  OS=Linux
elif [[ $OS == "Darwin" ]]; then
  OS=FreeBSD
fi

_zhist=$XDG_CONFIG_HOME/zsh.d/zhistory

export HISTFILE=${_zhist}/zsh_history
export _ZL_DATA=${_zhist}/zlua

HISTSIZE=100000
SAVEHIST=100000

ZDOTDIR=$XDG_CONFIG_HOME/zsh.d
ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump"

## workaround for handling TERM variable in multiple tmux sessions properly from http://sourceforge.net/p/tmux/mailman/message/32751663/[dead link 2020-04-03 ⓘ] by Nicholas Marriott
if [[ -n ${TMUX} && -n ${commands[tmux]} ]];then
        case $(tmux showenv TERM 2>/dev/null) in
                *256color) ;&
                TERM=fbterm)
                        TERM=screen-256color ;;
                *)
                        TERM=screen
        esac
fi

#[ -f $HOME/.bashrc ] && source $HOME/.bashrc

## https://github.com/farseerfc/dotfiles/blob/master/zsh/.zshrc.pre#L1-L16
POWERLINE_BINDINGS=/usr/share/powerline/bindings/
## load powerlevel10k or powerline or pure whichever installed
#if [[ -r "$HOME/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
#    # config for powerlevel10k
#    source ~/powerlevel10k/powerlevel10k.zsh-theme
#    # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#    [[ ! -f $XDG_CONFIG_HOME/zsh.d/p10k.zsh ]] || source $XDG_CONFIG_HOME/zsh.d/p10k.zsh
if [[ -x /usr/bin/starship ]]; then
    export STARSHIP_CONFIG=~/.config/starship.toml
    eval "$(starship init zsh)"
#elif [[ -f $XDG_CONFIG_HOME/zsh.d/p10k.zsh ]]; then
#    # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
#    # Initialization code that may require console input (password prompts, [y/n]
#    # confirmations, etc.) must go above this block, everything else may go below.
#    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#      source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#    fi
#    source $XDG_CONFIG_HOME/zsh.d/p10k.zsh
#    export __use_p10k=yes
elif [[ -r "/usr/share/zsh/functions/Prompts/prompt_pure_setup" ]]; then
    ## config for pure
    autoload -U promptinit; promptinit
    prompt pure
elif [[ -r "$POWERLINE_BINDINGS/zsh/powerline.zsh" ]]; then
    ## config for powerline
    powerline-daemon -q  # run powerline daemon
    source $POWERLINE_BINDINGS/zsh/powerline.zsh
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
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null

unset OS

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4;
