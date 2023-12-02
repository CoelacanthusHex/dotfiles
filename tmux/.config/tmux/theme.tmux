#!/usr/bin/bash

tmux set-option -g status-interval 1
tmux set-option -g status on
tmux set-option -g status-justify left

. ~/.config/tmux/palletes/tokyo-night.sh

# Status Bar
tmux set-option -g status-style "bg=${PALLETE[bg_highlight]},fg=${PALLETE[white]}"

# Message Style
tmux set-option -g message-style "bg=${PALLETE[red]},fg=${PALLETE[bg_dark]}"

# Border Color
tmux set-option -g pane-border-style "${PALLETE[bg_highlight]}"
tmux set-option -g pane-active-border-style "${PALLETE['dark5']}"


#tmux set-option -g display-panes-colour black
#tmux set-option -g display-panes-active-colour brightblack
#tmux set-window-option -g clock-mode-colour ${PALLETE['cyan']}

#tmux set-option -g message-command-style bg=brightblack,fg=${PALLETE['cyan']}

function generate_left_side_string() {
  local separator_end="#[bg=${PALLETE[bg_highlight]}]#{?client_prefix,#[fg=${PALLETE[yellow]}],#[fg=${PALLETE[green]}]}#[none]#[fg=${PALLETE[white]}] --> "

  echo "#[fg=${PALLETE[fg_gutter]},bold]#{?client_prefix,#[bg=${PALLETE[yellow]}],#[bg=${PALLETE[green]}]} [#S] ${separator_end}"
}

function generate_inactive_window_string() {
  local separator_start="#[bg=${PALLETE['dark5']},fg=${PALLETE['bg_highlight']}] #[none]"
  local separator_internal="#[bg=${PALLETE['dark3']},fg=${PALLETE['dark5']}] #[none]"
  local separator_end="#[bg=${PALLETE['bg_highlight']},fg=${PALLETE['dark3']}] #[none]"

  echo "${separator_start}#[fg=${PALLETE['white']}]###I ${separator_internal}#[fg=${PALLETE['white']}]#W ${separator_end}"
}

function generate_active_window_string() {
  separator_start="#[bg=${PALLETE['magenta']},fg=${PALLETE['bg_highlight']}] #[none]"
  separator_internal="#[bg=${PALLETE['purple']},fg=${PALLETE['magenta']}] #[none]"
  separator_end="#[bg=${PALLETE['bg_highlight']},fg=${PALLETE['purple']}] #[none]"

  echo "${separator_start}#[fg=${PALLETE['white']}]###I ${separator_internal}#[fg=${PALLETE['white']}]#W ${separator_end}#[none]"
}

function generate_right_side_string() {
  echo "#[fg=${PALLETE['white']},bg=${PALLETE['terminal_black']}] %F %T %z (%Z)#[fg=${PALLETE['cyan']},bg=${PALLETE['terminal_black']}] #[fg=${PALLETE['fg_gutter']},bg=${PALLETE['cyan']}] #H "
}

# Left Side
tmux set-option -g status-left "<#{prefix_highlight}> $(generate_left_side_string)"

# Windows List
tmux set-window-option -g window-status-format "$(generate_inactive_window_string)" 
tmux set-window-option -g window-status-current-format "$(generate_active_window_string)"

# Right Side
tmux set-option -g status-right "#{sysstat_cpu} | #{sysstat_mem} | #{sysstat_swap} | #{sysstat_loadavg} $(generate_right_side_string)"

tmux set-option -g window-status-separator " "
tmux set-option -g status-left-length 100
tmux set-option -g status-right-length 150

# Prefix Highlight
tmux set-option -g @prefix_highlight_fg "${PALLETE['white']}"
tmux set-option -g @prefix_highlight_bg "${PALLETE['blue2']}"
tmux set-option -g @prefix_highlight_copy_mode_attr "fg=${PALLETE[fg_dark]},bg=${PALLETE['cyan']}"
tmux set-option -g @prefix_highlight_empty_has_affixes 'on'
tmux set-option -g @prefix_highlight_empty_prompt 'Tmux'

# sysstat
tmux set-option -g @sysstat_mem_size_unit "G"
tmux set-option -g @sysstat_mem_view_tmpl 'MEM: #[fg=#{mem.color}]#{mem.pused}#[default] @ #{mem.used}/#{mem.total}'
tmux set-option -g @sysstat_swap_view_tmpl 'SWAP: #[fg=#{swap.color}]#{swap.pused}#[default] @ #{swap.used}/#{swap.total}'
tmux set-option -g @sysstat_cpu_view_tmpl 'CPU: #[fg=#{cpu.color}]#{cpu.pused}#[default]'
