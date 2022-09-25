#!/usr/bin/env zsh

if ! tty -s || [ ! -n "$TERM" ] || [ "$TERM" = dumb ] || (( ! $+commands[grc] ))
then
    return
fi

alias colourify="grc -es"

# Supported commands
cmds=(
    as
    ant
    blkid
    cc
    configure
    curl
    cvs
    df
    diff
    dig
    dnf
    docker
    docker-compose
    docker-machine
    du
    env
    fdisk
    findmnt
    free
    gas
    getfacl
    getsebool
    gpg
    id
    ifconfig
    iostat
    ip
    iptables
    iwconfig
    journalctl
    kubectl
    last
    ldap
    lolcat
    ld
    lsblk
    lsmod
    lsof
    lspci
    mount
    mvn
    netstat
    nmap
    ntpdate
    php
    proftpd
    ps
    sar
    semanage
    sensors
    showmount
    sockstat
    ss
    stat
    sysctl
    tcpdump
    traceroute
    traceroute6
    tune2fs
    ulimit
    uptime
    vmstat
    wdiff
    whois
)

# Set alias for available commands.
for cmd in $cmds ; do
    if (( $+commands[$cmd] )) ; then
        $cmd() {
            grc -es --colour=auto ${commands[$0]} "$@"
        }
    fi
done

# Clean up variables
unset cmds cmd

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4;
