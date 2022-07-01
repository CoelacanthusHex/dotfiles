#!/usr/bin/zsh
# shellcheck shell=bash
# The extension for standard zsh _hosts autocompletion
# Copyright 2021 Mikhail f. Shiryaev
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
###############
# DESCRIPTION #
###############
#
# This script does the next things:
# - Use async module to not block the flow
# - Preserve the original _hosts function as _hosts_orig
# - Adds configurable cache expiring for _cache_hosts
# - Executes each function in HOCO_FUNCTIONS and adds tabs, new lines and space separated values to _cache_hosts
#
#################
# CONFIGURATION #
#################
#
# HOCO stands for hosts completion
#
# HOCO_CACHE_AGE: cache expiration in `m+10` format for (mm+10), see ZSHEXPN(1) `modification time`
#                 default: m+10
# HOCO_FUNCTIONS: array of functions or commands to get hosts.
#                 Only single words are accepted, no arguments are allowed.
#                 The output will be split to arguments by '\n', '\t' and space symbols
#


# Preserve _hosts as _hosts_orig, but only once
if ! (( $_HOCO_INIT_DONE )); then
  typeset -g _HOCO_INIT_DONE=1

  # _hosts needs to be intiated before tweaking
  _hosts &>/dev/null || :

  eval "$(type -f _hosts | sed -r '1 s/_hosts/_hosts_orig/')"

  zstyle -t ":completion:${curcontext}:" use-cache || \
    echo "The $0 requires 'zstyle :completion:* use-cache on', otherwise it's updated only on start" >&2
fi

__hoco_cache_callback() {
  local fd="$1" curcontext func cache_name func_output
  local -a args
  # Remove handlers for the current descriptor
  zle -F "$fd"

  {
    # Get curcontext, function, and cache_name and close the descriptor
    read -ru $fd -d '|' -- curcontext
    read -ru $fd -d '|' -- func
    read -ru $fd -d '|' -- cache_name
    read -ru $fd  -- func_output

    # A few steps to split by '\n', '\t' and ' '
    set -A ${cache_name} "${(ps:\n:)func_output}"
    func_output="${(Ppj:\t:)cache_name}"
    set -A ${cache_name} "${(ps:\t:)func_output}"
    func_output="${(Ppj: :)cache_name}"
    set -A ${cache_name} "${(ps: :)func_output}"

    _store_cache ${cache_name#_} ${cache_name}
    # Wait if original $_cache_hosts is empty
    while (( $#_cache_hosts == 0 )); do
      sleep 0.1
    done
    set -A _cache_hosts ${_cache_hosts} ${(P)cache_name}
    # Avoid race condition
    while ! [[ "$_hoco_async_runs[${func}]" ]]; do
      sleep 0.1
    done
  } always {
    exec {fd}<&-
    unset _hoco_async_runs[${func}]
  }
}

__hoco_original_cache_callback() {
  local fd="$1"
  # Remove handlers for the current descriptor
  zle -F "$fd"

  {
    # Wait for _hosts_orig finished and populated $_cache_hosts
    while (( ${#_cache_hosts} == 0 )); do
      sleep 0.1
    done
    # Get curcontext
    read -ru $fd -- curcontext

    # Collect results of already finished functions
    # If the $func already finished, then it may be missed in _cache_hosts
    for func (${hoco_functions}); do
      if ! (( $#_hoco_async_runs[$func] )); then
        cache_name=_hoco_${func}
        set -A _cache_hosts ${_cache_hosts} ${(P)cache_name}
      fi
    done
    func=hoco-orig_cache_hosts
    _store_cache "${func}" _cache_hosts
    # Avoid race condition
    while ! [[ "$_hoco_async_runs[${func}]" ]]; do
      sleep 0.1
    done
  } always {
    exec {fd}<&-
    unset _hoco_async_runs["${func}"]
  }
}

_hosts() {
  local update_policy
  zstyle -s ":completion:${curcontext}:" cache-policy update_policy
  if [[ -z "$update_policy" ]]; then
    zstyle ":completion:${curcontext}:" cache-policy __hoco_cache_update_policy
  fi

  # Deduplicate HOCO_FUNCTIONS
  local -aU hoco_functions=(${HOCO_FUNCTIONS})
  # The global associated array for pids of async functions
  typeset -Ag _hoco_async_runs

  for func (${hoco_functions}); do
    cache_name=_hoco_${func}
    if ( [[ ${(P)+cache_name} -eq 0 ]] || _cache_invalid ${cache_name#_} ) &&
        ! _retrieve_cache ${cache_name#_}; then
      typeset -agU _hoco_${func}
      # Avoid double run
      [[ "$_hoco_async_runs[${func}]" ]] && continue

      local fd
      exec {fd}< <( # launch cache fillup in a handler to have the same shell environment
        local output="${curcontext}|${func}|${cache_name}|$(${func})"
        print -r -- "${output}"
      )
      _hoco_async_runs[${func}]="$sysparams[procsubstpid]"
      zle -F "${fd}" __hoco_cache_callback
    fi
  done

  # Original cache from upstream _hosts function. Never try to retrieve it
  if (( ${#_cache_hosts} == 0 )) || _cache_invalid hoco-orig_cache_hosts; then
    unset _cache_hosts
    local fd
    exec {fd}< <( # launch cache fillup in a handler to have the same shell environment
      print -r -- ${curcontext} # preserve $curcontext
    )
    _hoco_async_runs[hoco-orig_cache_hosts]="$sysparams[procsubstpid]"
    zle -F "${fd}" __hoco_original_cache_callback
  fi

  # original logic
  _hosts_orig
}

__hoco_cache_update_policy() {
  local -a old exists
  local check=$1

  # rebuild if cache is more than 10 minutes or does not exist
  old=( "$check"(m${HOCO_CACHE_AGE:-m+10}) )
  exists=( "$check"(.) )
  { (( $#old )) || ! (( $#exists )) } && return 0
  return 1
}

# vi: filetype=zsh
