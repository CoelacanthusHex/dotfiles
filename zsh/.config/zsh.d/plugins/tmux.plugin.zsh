zmodload zsh/terminfo

#[[ $terminfo[Tc] == yes && -z $COLORTERM ]] && export COLORTERM=truecolor

local -a cmds=()
if (( terminfo[colors] >= 256 )); then
    cmds+=(set -g default-terminal tmux-256color ';')
    if [[ $COLORTERM == (24bit|truecolor) ]]; then
        # https://github.com/romkatv/zsh4humans/commit/6b30738bd30da18273c2af53a37f699383d79b53
        cmds+=(set -ga terminal-features ',*:RGB:usstyle:overline' ';')
    fi
else
    # The default has changed in the newer version tmux.
    # https://github.com/romkatv/zsh4humans/commit/0341b78cdec2833a6b0e7bbb06a2ee625311c704
    cmds+=(set -g default-terminal tmux ';')
fi

# https://github.com/lilydjwg/dotzsh/blob/313050449529c84914293283691da1e824d779f5/zshrc#L385
# for systemd 230+
# see https://github.com/tmux/tmux/issues/428
if (( $_has_re == 1 )) && \
    (( $+commands[tmux] )) && (( $+commands[systemctl] )); then
    [[ $(systemctl --version) =~ 'systemd ([0-9]+)' ]] || true
    if (( $match >= 230 )); then
        function tmux () {
            if command tmux has; then
                if (( $#@ == 0 )); then
                    command tmux "${cmds[@]}" attach $@
                elif (( ${#@[(r)(attach|attach-session)]} )); then
                    command tmux "${cmds[@]}" $@
                else
                    command tmux "${cmds[@]}" $@
                fi
            else
                if (( $#@ == 0 )); then
                    systemd-run --user --scope tmux "${cmds[@]}" new $@
                elif (( ${#@[(r)(new|new-session)]} )); then
                    systemd-run --user --scope tmux "${cmds[@]}" $@
                else
                    command tmux $@
                fi
            fi 
        }
    fi
    unset match
fi

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4;
