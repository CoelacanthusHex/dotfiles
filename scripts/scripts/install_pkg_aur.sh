#!/usr/bin/env bash

yay -S $(diff <(cat pkglist | sort) <(pacman -Slq | sort) | grep \< | cut -f2 -d' ')
