vim9script
# vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
# kate: space-indent on; indent-width 4; syntax vim;

# SPDX-License-Identifier: MPL-2.0
# SPDX-FileCopyrightText: Coelacanthus

packadd dein

# In Windows, auto_recache is disabled.  It is too slow.
g:dein#auto_recache = !has('win32')
g:dein#install_progress_type = 'floating'

$CACHE = expand('~/.cache')
if !isdirectory($CACHE)
    mkdir($CACHE, 'p')
endif
var path = $CACHE .. '/dein'
if dein#min#load_state(path)
    var base_dir = fnamemodify(expand('<sfile>'), ':h') .. '/dein.d/'

    var dein_toml = base_dir .. 'normal.toml'
    var dein_lazy_toml = base_dir .. 'lazy.toml'
    var dein_ddc_toml = base_dir .. 'ddc.toml'

    dein#begin(path, [
            \ expand('<sfile>'), dein_toml, dein_lazy_toml
            \ ])

    dein#load_toml(dein_toml, {'lazy': 0})
    dein#load_toml(dein_lazy_toml, {'lazy': 1})
    dein#load_toml(dein_ddc_toml, {'lazy': 1})

    dein#end()
    dein#save_state()
endif
