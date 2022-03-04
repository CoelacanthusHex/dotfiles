vim9script
# vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
# kate: space-indent on; indent-width 4; syntax vim;

# SPDX-License-Identifier: MPL-2.0
# SPDX-FileCopyrightText: Coelacanthus

if exists("g:loaded_auto_mkdir")
    finish
endif
g:loaded_auto_mkdir = 1

def AutoMkdir()
    # Get directory the file is supposed to be saved in
    var dir = expand("<afile>:p:h")

    # Create that directory (and its parents) if it doesn't exist yet
    if !isdirectory(dir)
        mkdir(dir, "p")
    endif
enddef

augroup AutoMkdir
    au!
    autocmd BufWritePre,FileWritePre * AutoMkdir()
augroup END
