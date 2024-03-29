# shellcheck disable=1091

autoload -Uz colors && colors

function _prompt.p10k.post_hook() { : }

autoload -Uz is-at-least
if  (( ! $disable_p10k )) && is-at-least 5.1.0 \
        && [[ -r "$ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
    if [[ -r "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
        source "${XDG_CACHE_HOME}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi
    source "$ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme"
    function _prompt.p10k.post_hook() {
        [[ ! -f ~/.config/zsh.d/p10k.zsh ]] || source ~/.config/zsh.d/p10k.zsh
    }
elif (( ! $disable_starship )) && (( $+commands[starship] )) \
        && is-at-least 1.2.0 $(starship --version | head -n 1 | cut -d' ' -f2); then
    export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship.toml"
    smartcache eval starship init zsh
elif (( ! $disable_async_prompt )) && (( $+commands[git] )); then
    ## config for async
    # Modify from https://blog.lilydjwg.me/2014/2/19/asynchronously-update-zsh-prompt.42906.html

    # Remove RPROMPT after execute command
    setopt transient_rprompt
    # Allow function in prompt
    setopt prompt_subst

    source "$ZDOTDIR/prompt.init.zsh"
    _prompt.pipestatus.init
    _prompt.vcs_status.init

    autoload -Uz add-zsh-hook
    add-zsh-hook precmd _prompt.set_pipe_status
    add-zsh-hook precmd _prompt.set_git_status
    
    PROMPT='%F{cyan}%n%f @ %F{magenta}%m%f in %B%F{yellow}%~%f%b$_current_branch$_current_status%f -> $_pipe_status%f
%(?.%F{green}.%F{red})>>>%f '
    RPROMPT="%T"
    PROMPT2="%F{yellow}>>>%f "
elif (( ! $disable_pure )) \
        && [[ -r "/usr/share/zsh/functions/Prompts/prompt_pure_setup" ]] \
        || (autoload -U promptinit && promptinit; prompt -l | grep pure); then
    ## config for pure
    autoload -U promptinit && promptinit
    prompt pure
else
    ## config for fallback
    
    # Remove RPROMPT after execute command
    setopt transient_rprompt
    # Allow function in prompt
    setopt prompt_subst

    source "$ZDOTDIR/prompt.init.zsh"
    _prompt.pipestatus.init

    autoload -Uz vcs_info add-zsh-hook
    add-zsh-hook precmd vcs_info
    add-zsh-hook precmd _prompt.set_pipe_status

    zstyle ':vcs_info:*' formats '%F{green}(%s)%f-%F{red}[%b]%f%u%c%F{blue}%m%f'
    zstyle ':vcs_info:*' actionformats '%F{green}(%s)%f-%F{red}[%b|%a]%f%u%c%F{blue}%m%f'
    zstyle ':vcs_info:git*+set-message:*' hooks git-st
    zstyle ':vcs_info:*' enable git hg svn

    PROMPT='%F{cyan}%n%f @ %F{magenta}%m%f in %B%F{yellow}%~%f%b at $vcs_info_msg_0_ -> $_pipe_status%f
%(?.%F{green}.%F{red})>>>%f '
    RPROMPT="%T"
    PROMPT2="%F{yellow}>>>%f "
fi

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4; syntax zsh;
