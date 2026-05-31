#!/usr/bin/env zsh
# SPDX-FileCopyrightText: Copyright (c) 2023 Sophie Tyalie
# SPDX-FileCopyrightText: Copyright (c) 2023 @Nezteb
# SPDX-License-Identifier: BSD-3-Clause
# SPDX-PackageHomePage: https://gist.github.com/tyalie/7e13cfe2ec62d99fa341a07ed12ef7c0

#----------------------------------
# main
#----------------------------------

# global configuration
: ${ATUIN_HISTORY_SEARCH_FILTER_MODE='session-preload'}

# internal variables
typeset -g -i _atuin_history_search_zsh_5_9
typeset -g -i _atuin_history_match_index
typeset -g _atuin_history_search_result
typeset -g _atuin_history_search_query
typeset -g _atuin_history_refresh_display

#-----------END main---------------

#----------------------------------
# implementation details
#----------------------------------

zmodload -F zsh/parameter
autoload -Uz is-at-least

if is-at-least 5.9 $ZSH_VERSION; then
  _atuin_history_search_zsh_5_9=1
fi

_atuin-history-search-begin() {
  # assume we will not render anything
  _atuin_history_refresh_display=

  # If the buffer is the same as the previously displayed history substring
  # search result, then just keep stepping through the match list. Otherwise
  # start a new search.
  if [[ -n $BUFFER && $BUFFER == ${_atuin_history_search_result:-} ]]; then
    return;
  fi

  # Clear the previous result.
  _atuin_history_search_result=''

  # setup our search query
  if [[ -z $BUFFER ]]; then
    _atuin_history_search_query=
  else
    _atuin_history_search_query="$BUFFER"
  fi

  # reset search index
  _atuin_history_match_index=0
}

_atuin-history-search-end() {

  local highlight_memo=

  if [[ $_atuin_history_search_zsh_5_9 -eq 1 ]]; then
    highlight_memo='memo=atuin-history-search'
  fi

  # if our index is <= 0 just print the query we started with
  if [[ $_atuin_history_match_index -le 0 ]]; then
    _atuin_history_search_result="$_atuin_history_search_query"
  fi

  # draw buffer if requested
  if [[ $_atuin_history_refresh_display -eq 1 ]]; then
    BUFFER="$_atuin_history_search_result"
    if [[ -n $highlight_memo ]]; then
      region_highlight=( "${(@)region_highlight:#*${highlight_memo}*}" )
    else
      region_highlight=()
    fi
    CURSOR="${#BUFFER}"
  fi

  _zsh_highlight


  # highlight the search query inside the command line
  # TODO: it seems we can't implement it becasue search process is handled by
  #       atuin cli, so we don't know how the query was break.
  if false && [[ -n $_atuin_history_search_query_highlight ]]; then
    # highlight first matching query parts
    local highlight_start_index=0
    local highlight_end_index=0
    local query_part
    for query_part in $_atuin_history_search_query_parts; do
      local escaped_query_part=${query_part//(#m)[\][()|\\*?#<>~^]/\\$MATCH}
      # (i) get index of pattern
      local query_part_match_index="${${BUFFER:$highlight_start_index}[(i)(#$atuin_history_SEARCH_GLOBBING_FLAGS)${escaped_query_part}]}"
      if [[ $query_part_match_index -le ${#BUFFER:$highlight_start_index} ]]; then
        highlight_start_index=$(( $highlight_start_index + $query_part_match_index ))
        highlight_end_index=$(( $highlight_start_index + ${#query_part} ))
        region_highlight+=(
          "$(($highlight_start_index - 1)) $(($highlight_end_index - 1)) ${_atuin_history_search_query_highlight}${highlight_memo:+,$highlight_memo}"
        )
      fi
    done
  fi

  # for debug purposes only
  #zle -R "mn: "$_atuin_history_match_index" / qr: $_atuin_history_search_result"
  #read -k -t 1 && zle -U $REPLY

  #
  # When this function returns, z-sy-h runs its line-pre-redraw hook. It has no
  # logic for determining highlight priority, when two different memo= marked
  # region highlights overlap; instead, it always prioritises itself. Below is
  # a workaround for dealing with it.
  #
  if false && [[ $_atuin_history_search_zsh_5_9 -eq 1 ]]; then
    zle -R
    #
    # After line redraw with desired highlight, wait for timeout or user input
    # before removing search highlight and exiting. This ensures no highlights
    # are left lingering after search is finished.
    #
    read -k -t ${ATUIN_HISTORY_SEARCH_HIGHLIGHT_TIMEOUT:-1} && zle -U -- "$REPLY"
    region_highlight=( "${(@)region_highlight:#*${highlight_memo}*}" )
  fi

}

_atuin-history-up-buffer() {
  # attribution to zsh-history-substring-search
  #
  # Check if the UP arrow was pressed to move the cursor within a multi-line
  # buffer. This amounts to three tests:
  #
  # 1. $#buflines -gt 1.
  #
  # 2. $CURSOR -ne $#BUFFER.
  #
  # 3. Check if we are on the first line of the current multi-line buffer.
  #    If so, pressing UP would amount to leaving the multi-line buffer.
  #
  #    We check this by adding an extra "x" to $LBUFFER, which makes
  #    sure that xlbuflines is always equal to the number of lines
  #    until $CURSOR (including the line with the cursor on it).
  #
  local buflines XLBUFFER xlbuflines
  buflines=(${(f)BUFFER})
  XLBUFFER=$LBUFFER"x"
  xlbuflines=(${(f)XLBUFFER})

  if [[ $#buflines -gt 1 && $CURSOR -ne $#BUFFER && $#xlbuflines -ne 1 ]]; then
    zle up-line-or-history
    return 0
  fi

  return 1
}

_atuin-history-down-buffer() {
  # attribution to zsh-history-substring-search
  #
  # Check if the DOWN arrow was pressed to move the cursor within a multi-line
  # buffer. This amounts to three tests:
  #
  # 1. $#buflines -gt 1.
  #
  # 2. $CURSOR -ne $#BUFFER.
  #
  # 3. Check if we are on the last line of the current multi-line buffer.
  #    If so, pressing DOWN would amount to leaving the multi-line buffer.
  #
  #    We check this by adding an extra "x" to $RBUFFER, which makes
  #    sure that xrbuflines is always equal to the number of lines
  #    from $CURSOR (including the line with the cursor on it).
  #
  local buflines XRBUFFER xrbuflines
  buflines=(${(f)BUFFER})
  XRBUFFER="x"$RBUFFER
  xrbuflines=(${(f)XRBUFFER})

  if [[ $#buflines -gt 1 && $CURSOR -ne $#BUFFER && $#xrbuflines -ne 1 ]]; then
    zle down-line-or-history
    return 0
  fi

  return 1
}

_atuin-history-up-search() {
  _atuin_history_match_index+=1

  offset=$((_atuin_history_match_index-1))
  search_result=$(_atuin-history-do-search $offset "$_atuin_history_search_query")

  if [[ -z $search_result ]]; then
    # if search result is empty, there's no more history
    # so just show the previous result
    _atuin_history_match_index+=-1
    return 1
  fi

  _atuin_history_refresh_display=1
  _atuin_history_search_result="$search_result"
  return 0
}

_atuin-history-down-search() {
  # we can't go below 0
  if [[ $_atuin_history_match_index -le 0 ]]; then
    return 1
  fi

  _atuin_history_refresh_display=1
  _atuin_history_match_index+=-1

  offset=$((_atuin_history_match_index-1))
  _atuin_history_search_result=$(_atuin-history-do-search $offset "$_atuin_history_search_query")

  return 0
}

_atuin-history-do-search() {
  if [[ $1 -ge 0 ]]; then
    atuin search --filter-mode "$ATUIN_HISTORY_SEARCH_FILTER_MODE" --search-mode prefix \
      --limit 1 --offset $1 --format "{command}" \
      "$2"
  fi
}

_atuin-history-up() {
  _atuin-history-search-begin

  # iteratively use the next mechanism to process up if the previous didn't succeed
  _atuin-history-up-buffer || _atuin-history-up-search

  _atuin-history-search-end
}

_atuin-history-down() {
  _atuin-history-search-begin

  # iteratively use the next mechanism to process down if the previous didn't succeed
  _atuin-history-down-buffer || _atuin-history-down-search #|| zle _atuin_search_widget

  _atuin-history-search-end
}

zle -N atuin-history-up _atuin-history-up
zle -N atuin-history-up-vicmd _atuin-history-up
zle -N atuin-history-up-viins _atuin-history-up
zle -N atuin-history-down _atuin-history-down
zle -N atuin-history-down-vicmd _atuin-history-down
zle -N atuin-history-down-viins _atuin-history-down

bindkey -M emacs "$key[Up]" atuin-history-up
bindkey -M vicmd "$key[Up]" atuin-history-up-vicmd
bindkey -M viins "$key[Up]" atuin-history-up-viins
bindkey -M vicmd 'k' atuin-history-up-vicmd
bindkey -M emacs "$key[Down]" atuin-history-down
bindkey -M vicmd "$key[Down]" atuin-history-down-vicmd
bindkey -M viins "$key[Down]" atuin-history-down-viins
bindkey -M vicmd 'j' atuin-history-down-vicmd

#------END implementation----------
