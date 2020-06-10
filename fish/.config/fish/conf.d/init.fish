function l
    exa -lah $argv
end

function ll
    exa -l $argv
end

function la
    exa -a $argv
end

function ls
    exa
end

function sysupg
    sudo pacman -Sy; and sudo powerpill -Suw $argv; and sudo pacman -Su $argv
    pacman -Qtdq | ifne sudo pacman -Rsc -
end

function pc
    proxychains -q $argv
end

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

set fish_function_path $fish_function_path "/usr/lib/python3.8/site-packages/powerline/bindings/fish"
powerline-setup
