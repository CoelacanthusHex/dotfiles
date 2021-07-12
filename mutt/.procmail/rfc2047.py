#!/usr/bin/env python3
from email.header import decode_header
import sys
for t in decode_header(sys.stdin.read()):
    if t[1] != None:
        print(t[0].decode(t[1]), end='')
    else:
        if isinstance(t[0], str):
            print(t[0], end='')
        else:
            print(t[0].decode('ascii'), end='')
