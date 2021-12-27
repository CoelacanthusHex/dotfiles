
_enabled_plugins=(
    command-not-found
    git
    colored-man-pages
    autopair
    fast-syntax-highlighting/fast-syntax-highlighting
)
for _zsh_plugin in $_enabled_plugins[@]; do
    [[ ! -r "$XDG_CONFIG_HOME/zsh.d/plugins/$_zsh_plugin.plugin.zsh" ]] || source $XDG_CONFIG_HOME/zsh.d/plugins/$_zsh_plugin.plugin.zsh
done

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4;
