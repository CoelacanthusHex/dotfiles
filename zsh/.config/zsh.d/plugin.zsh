
_enabled_plugins=(
    command-not-found
    git
    colored-man-pages
    sudo
    autopair
)
for _zsh_plugin in $_enabled_plugins[@]; do
    [[ ! -r "$XDG_CONFIG_HOME/zsh.d/plugins/$_zsh_plugin.plugin.zsh" ]] || source $XDG_CONFIG_HOME/zsh.d/plugins/$_zsh_plugin.plugin.zsh
done
