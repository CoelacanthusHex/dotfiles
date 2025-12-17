#!/usr/bin/env python3
# SPDX-FileCopyrightText: 2025 Jan Lübbe <jlu@pengutronix.de>
# SPDX-License-Identifier: BSD-3-Clause

# add to the relevant Host section in your .ssh/config:
#   ProxyUseFdpass yes
#   ProxyCommand ~/bin/mptcp_fdpass.py %h %p
#   ProxyCommand ~/bin/mptcp_fdpass.py -4 %h %p   # force IPv4
#   ProxyCommand ~/bin/mptcp_fdpass.py -6 %h %p   # force IPv6

import sys
import os
import socket
import array
import errno
import struct
import argparse


def eprint(*args):
    print(*args, file=sys.stderr, flush=True)


def send_connected_fd_to_ssh(s: socket.socket) -> None:
    """Pass the connected socket fd to ssh via stdout/stderr pipe using SCM_RIGHTS."""
    fds = array.array("i", [s.fileno()])
    anc = [(socket.SOL_SOCKET, socket.SCM_RIGHTS, fds)]

    # Prefer stdout (fd=1), fall back to stdin (fd=0)
    for fd in (1, 0):
        try:
            dupfd = os.dup(fd)  # avoid closing the real stdio fd
            out = socket.socket(fileno=dupfd)
            try:
                out.sendmsg([b"\0"], anc)  # send one byte + the fd
                return
            finally:
                try:
                    out.close()
                except Exception:
                    pass
        except OSError as ex:
            # Not a socket or unsupported—try the next candidate
            if ex.errno not in (errno.ENOTSOCK, errno.EOPNOTSUPP):
                raise
    raise OSError("failed to pass fd on stdout or stdin")


def connect_mptcp(host: str, port: int, family_hint: int = 0) -> socket.socket:
    # Strip IPv6 brackets if present
    if host.startswith("[") and host.endswith("]"):
        host = host[1:-1]

    last_err = None
    for family, _, _, _, sockaddr in socket.getaddrinfo(
        host, port, family_hint, socket.SOCK_STREAM, 0, socket.AI_ADDRCONFIG
    ):
        try:
            s = socket.socket(family, socket.SOCK_STREAM, socket.IPPROTO_MPTCP)
            s.connect(sockaddr)
            return s
        except OSError as ex:
            last_err = ex
            try:
                s.close()
            except Exception:
                pass
    if last_err:
        raise last_err
    raise OSError("no usable addresses from getaddrinfo")


def tcp_is_mptcp(s: socket.socket):
    """Return True/False if kernel reports MPTCP/TCP, or None if unsupported."""
    TCP_IS_MPTCP = 43  # Linux API to detect MPTCP fallback
    try:
        val = s.getsockopt(socket.IPPROTO_TCP, TCP_IS_MPTCP, 4)
        return bool(struct.unpack("i", val)[0])
    except OSError:
        return None


def parse_args():
    p = argparse.ArgumentParser(
        description="ProxyCommand helper that connects via Multipath TCP and fd-passes the socket to ssh."
    )
    fam = p.add_mutually_exclusive_group()
    fam.add_argument("-4", dest="force_v4", action="store_true", help="Force IPv4")
    fam.add_argument("-6", dest="force_v6", action="store_true", help="Force IPv6")
    p.add_argument("host", help="Target host (%%h)")
    p.add_argument("port", type=int, help="Target port (%%p)")
    return p.parse_args()


def main():
    args = parse_args()

    family_hint = 0
    if args.force_v4:
        family_hint = socket.AF_INET
    elif args.force_v6:
        family_hint = socket.AF_INET6

    try:
        s = connect_mptcp(args.host, args.port, family_hint)
        is_mptcp = tcp_is_mptcp(s)
        if is_mptcp is True:
            eprint(f"MPTCP: connected via MPCTP to {args.host}:{args.port}")
        elif is_mptcp is False:
            eprint(
                f"MPTCP: warning: kernel fell back to TCP for {args.host}:{args.port}"
            )
        else:
            eprint(
                f"MPTCP: connected to {args.host}:{args.port} (MPTCP status unknown)"
            )

        send_connected_fd_to_ssh(s)
        try:
            s.close()
        except Exception:
            pass
        sys.exit(0)
    except Exception as ex:
        eprint(f"MPTCP: error: {ex}")
        sys.exit(1)


if __name__ == "__main__":
    main()
