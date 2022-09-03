
_enabled_plugins=(
    command-not-found
    git
    better-man-pages
    autopair
    fast-syntax-highlighting/fast-syntax-highlighting
    history-search-multi-word/history-search-multi-word
    zsh-autosuggestions/zsh-autosuggestions
    zsh-history-substring-search/zsh-history-substring-search
    zsh-edit/zsh-edit
    tmux
    cpan-completion # https://github.com/MenkeTechnologies/zsh-cpan-completion
    #zsh-async/async
    nix-zsh-completions/nix
    dotenv
)
for _zsh_plugin in $_enabled_plugins[@]; do
    [[ ! -r "$ZDOTDIR/plugins/$_zsh_plugin.plugin.zsh" ]] || source $ZDOTDIR/plugins/$_zsh_plugin.plugin.zsh
done

### Autosuggest Setting
export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)
export ZSH_AUTOSUGGEST_USE_ASYNC=true
# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
    OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
    zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}
pastefinish() {
    zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
# https://github.com/zsh-users/zsh-autosuggestions/issues/351
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste accept-line)

# https://github.com/zsh-users/zsh-history-substring-search#usage
zmodload zsh/terminfo
#bindkey "$terminfo[kcuu1]" history-substring-search-up
#bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
export HISTORY_SUBSTRING_SEARCH_PREFIXED=true

# Number of entries to show (default is $LINES/3)
zstyle ":history-search-multi-word" page-size "7"
# Color in which to highlight matched, searched text (default bg=17 on 256-color terminals)
zstyle ":history-search-multi-word" highlight-color "fg=yellow,bold"
# Whether to perform syntax highlighting (default true)
zstyle ":plugin:history-search-multi-word" synhl "yes"
# Effect on active history entry. Try: standout, bold, bg=blue (default underline)
zstyle ":plugin:history-search-multi-word" active "underline"
# Whether to check paths for existence and mark with magenta (default true)
zstyle ":plugin:history-search-multi-word" check-paths "yes"
# Whether pressing Ctrl-C or ESC should clear entered query
zstyle ":plugin:history-search-multi-word" clear-on-cancel "no"

# zsh-edit
zstyle ':edit:*' word-chars ''

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4;
