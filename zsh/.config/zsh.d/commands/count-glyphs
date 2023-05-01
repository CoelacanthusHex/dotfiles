#!/bin/bash
[[ -f "$1" ]] && fc='fc-query' || fc='fc-match'

for range in $($fc --format='%{charset}\n' "$1"); do
    for n in $(seq "0x${range%-*}" "0x${range#*-}"); do
        printf "\n"
    done
done | wc -l
