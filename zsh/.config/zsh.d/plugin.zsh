# zsh-autosuggestion
# Disable auto set keybind when precmd
export ZSH_AUTOSUGGEST_MANUAL_REBIND=true
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
# Disable autosuggestion for too long line (over 80 chars)
ZSH_AUTOSUGGEST_HISTORY_IGNORE='?(#c80,)'

# zsh-history-substring-search
export HISTORY_SUBSTRING_SEARCH_PREFIXED=true
# Treat 'ab c' as '*ab*c*'
export HISTORY_SUBSTRING_SEARCH_FUZZY=true

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

# fzf-tab
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview 'ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags '--preview-window=down:3:wrap'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' switch-group '<' '>'

_enabled_plugins=(
    git
    better-man-pages
    #zsh-sqlite/zsh-sqlite
    zsh-autopair/zsh-autopair
    fast-syntax-highlighting/fast-syntax-highlighting
    zsh-autosuggestions/zsh-autosuggestions
    #history-search-multi-word/history-search-multi-word
    #zsh-history-substring-search/zsh-history-substring-search
    zsh-edit/zsh-edit
    cpan-completion # https://github.com/MenkeTechnologies/zsh-cpan-completion
    nix-zsh-completions/nix
    dotenv
    zsh-ssh/zsh-ssh
    atuin
)

if (( $+commands[fzf] )); then
    _enabled_plugins+=(fzf-tab/fzf-tab)
    ZSH_AUTOSUGGEST_STRATEGY=("atuin" "${ZSH_AUTOSUGGEST_STRATEGY[@]}")
fi

for _zsh_plugin in $_enabled_plugins[@]; do
    [[ ! -r "$ZDOTDIR/plugins/$_zsh_plugin.plugin.zsh" ]] || source $ZDOTDIR/plugins/$_zsh_plugin.plugin.zsh
done

# Fast syntax highlighting
FAST_HIGHLIGHT[use_async]=1
# FIXME: it's too slow.
# https://github.com/zdharma-continuum/fast-syntax-highlighting/commit/3d574ccf48804b10dca52625df13da5edae7f553
# https://github.com/zdharma-continuum/fast-syntax-highlighting/pull/82
#FAST_HIGHLIGHT[chroma-make-cache-global]=1
# I want to disable HEX color string highlight, but it seems no way...
# https://github.com/zdharma-continuum/fast-syntax-highlighting/blob/cf318e06a9b7c9f2219d78f41b46fa6e06011fd9/fast-highlight#L1152

#bindkey "$key[Up]" history-substring-search-up
#bindkey "$key[Down]" history-substring-search-down

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4;
