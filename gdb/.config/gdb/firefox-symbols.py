# Any copyright is dedicated to the Public Domain.
# http://creativecommons.org/publicdomain/zero/1.0/
#
# A GDB Python script to fetch debug symbols from the Mozilla symbol server.
#
# To use, run `source /path/to/symbols.py` in GDB 7.9 or newer, or
# put that in your ~/.gdbinit.

from __future__ import print_function

import itertools
import os
import subprocess
from urllib.parse import urljoin, quote

SYMBOL_SERVER_URL = 'https://s3-us-west-2.amazonaws.com/org.mozilla.crash-stats.symbols-public/v1/'

debug_dir = os.path.join(os.environ['HOME'], '.cache', 'gdb')
cache_dir = os.path.join(debug_dir, '.build-id')

def munge_build_id(build_id):
    '''
    Breakpad stuffs the build id into a GUID struct so the bytes are
    flipped from the standard presentation.
    '''
    b = list(map(''.join, list(zip(*[iter(build_id.upper())]*2))))
    return ''.join(itertools.chain(reversed(b[:4]), reversed(b[4:6]),
                                   reversed(b[6:8]), b[8:16])) + '0'

def try_fetch_symbols(filename, build_id, destination):
    debug_file = os.path.join(destination, build_id[:2], build_id[2:] + '.debug')
    if os.path.exists(debug_file):
        return debug_file
    try:
        d = os.path.dirname(debug_file)
        if not os.path.isdir(d):
            os.makedirs(d)
    except OSError:
        pass
    path = os.path.join(filename, munge_build_id(build_id), filename + '.dbg.gz')
    url = urljoin(SYMBOL_SERVER_URL, quote(path))
    try:
        print('Fetching symbols from {0}'.format(url))
        cmd = f'wget --retry-connrefused --retry-on-host-error -T5 -t100 -c --no-use-server-timestamps "{url}" -O- | gunzip > "{debug_file}"'
        subprocess.check_call(cmd, shell=True)
        return debug_file
    except:
        return None


def is_moz_binary(filename):
    '''
    Try to determine if a file lives in a Firefox install dir, to save
    HTTP requests for things that aren't going to work.
    '''
    # The linux-gate VDSO doesn't have a real filename.
    if not os.path.isfile(filename):
        return False
    while True:
        filename = os.path.dirname(filename)
        if filename == '/':
            return False
        if os.path.isfile(os.path.join(filename, 'application.ini')):
            return True


def fetch_symbols_for(objfile):
    build_id = objfile.build_id if hasattr(objfile, 'build_id') else None
    if getattr(objfile, 'owner', None) is not None or any(o.owner == objfile for o in gdb.objfiles()):
        # This is either a separate debug file or this file already
        # has symbols in a separate debug file.
        return
    if build_id and is_moz_binary(objfile.filename):
        debug_file = try_fetch_symbols(os.path.basename(objfile.filename), build_id, cache_dir)
        if debug_file:
            objfile.add_separate_debug_file(debug_file)


def new_objfile(event):
    fetch_symbols_for(event.new_objfile)


def fetch_symbols():
    '''
    Try to fetch symbols for all loaded modules.
    '''
    for objfile in gdb.objfiles():
        fetch_symbols_for(objfile)

# Create our debug cache dir.
try:
    if not os.path.isdir(cache_dir):
        os.makedirs(cache_dir)
except OSError:
    pass

# Set it as a debug-file-directory.
try:
    dirs = gdb.parameter('debug-file-directory').split(':')
except gdb.error:
    dirs = []
if debug_dir not in dirs:
    dirs.append(debug_dir)
    gdb.execute('set debug-file-directory %s' % ':'.join(dirs))

gdb.events.new_objfile.connect(new_objfile)
