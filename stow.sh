#!/bin/bash

#dotfiles=(zsh nvim)
#
#for dotfile in "${dotfiles[@]}"; do
#    stow -v -t ~ $dotfile
#done

set -e # exit on fail
apps=$* # all arguments
cd $(dirname "$0") # change working directory to here
stow --verbose --restow $apps # symlink configurations
for app in $apps; do
    if [[ -f $app/package.list ]]; then
        packages+=" $(cat $app/package.list)"
    fi # collect dependencies
done
[[ -n $packages ]] && sudo pacman -S --needed $packages # install dependencies
