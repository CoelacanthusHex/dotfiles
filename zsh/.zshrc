# 确定环境 {{{1
OS=${$(uname)%_*}
LSB_DISTRIBUTOR=`lsb_release -i -s`
if [[ $OS == "CYGWIN" || $OS == "MSYS" ]]; then
  OS=Linux
elif [[ $OS == "Darwin" ]]; then
  OS=FreeBSD
fi

_zhist=$HOME/.zsh.d/zhistory

export HISTFILE=${_zhist}/zsh_history
export _ZL_DATA=${_zhist}/zlua

ZDOTDIR=$HOME/.zsh.d
ZSH_COMPDUMP="${HOME}/.zsh.d/zcache/zcompdump"

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

# 也许未来会启用
#POWERLINE_BINDINGS=/usr/share/powerline/bindings/
#powerline-daemon -q  # run powerline daemon
#source $POWERLINE_BINDINGS/zsh/powerline.zsh


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#[ -f $HOME/.bashrc ] && source $HOME/.bashrc

source $HOME/.zsh.d/plugin.zsh
source $HOME/.zsh.d/completion.zsh
source $HOME/.zsh.d/config.zsh
source $HOME/.zsh.d/function.zsh
source $HOME/.zsh.d/Arch.zsh
source $HOME/.zsh.d/alias.zsh


#export PYTHONPATH=$PYTHONPATH:$HOME/Data/workspace/package/lilac:$HOME/Data/workspace/package/lilac/lilac2/vendor
#export PATH=$PATH:$HOME/Data/workspace/package/lilac

# Load user config.
if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $HOME/.zsh.d/p10k.zsh ]] || source $HOME/.zsh.d/p10k.zsh

unset OS

# vim: ft=zsh
