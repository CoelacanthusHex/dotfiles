#!/usr/bin/env bash

pacman -S --needed $(diff <(cat pkglist | sort) <(diff <(cat badpkglist | sort) <(pacman -Slq | sort) | grep \< | cut -f2 -d' ') | grep \< | cut -f2 -d' ')
