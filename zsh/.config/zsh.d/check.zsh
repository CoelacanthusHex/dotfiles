# Check Variable List
# $_in_kitty     : check whether in Kitty
# $_has_re       : check whether has regex engine
# $_in_x11       : check whether in X11
# $_in_wayland   : check whether in Wayland
# $_in_gui       : check whether in GUI
# $_in_linux_tty : check whether in Linux tty (only support ASCII and 16 colors)

[[ x$TERM == xxterm-kitty ]] && _in_kitty=1 || _in_kitty=0

zmodload zsh/regex 2>/dev/null && _has_re=1 || _has_re=0

# https://discourse.ubuntu.com/t/environment-variables-for-wayland-hackers/12750
# https://askubuntu.com/questions/432255/what-is-the-display-environment-variable
if [[ -z $WAYLAND_DISPLAY ]]; then
    _in_wayland=0
    if [[ -z $DISPLAY ]]; then
        _in_x11=0
    else
        _in_x11=1
    fi
else
    _in_wayland=1
    _in_x11=0
fi
(( $_in_x11 == 1 )) || (( $_in_wayland == 1 )) && _in_gui=1 || _in_gui=0

if (( $+commands[tty] )); then
    case $(tty) in
        (/dev/tty*) _in_linux_tty=1 ;;
        (*) _in_linux_tty=0 ;;
    esac
elif (( $+TERM == 1 )); then
    [[ x$TERM == xlinux ]] && _in_linux_tty=1 || _in_linux_tty=0
fi

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4;
