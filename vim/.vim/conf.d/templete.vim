vim9script
# vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
# kate: space-indent on; indent-width 4;

# 新文件标题

# 新建.c,.h,.sh,.java文件，自动插入文件头
autocmd BufNewFile *.sh,*.rb,*.pl,*.py execute SetTitle()
# 定义函数SetTitle，自动插入文件头
def SetTitle()
    if &filetype == 'sh'
        setline(1, "\#!/bin/bash")
        append(line("."), "")
    elseif &filetype == 'python'
        setline(1, "#!/usr/bin/env python")
        append(line("."), "# coding=utf-8")
        append(line(".")+1, "")

    elseif &filetype == 'ruby'
        setline(1, "#!/usr/bin/env ruby")
        append(line("."),"# encoding: utf-8")
        append(line(".")+1, "")

    elseif &filetype == 'perl'
        setline(1,"#!/usr/bin/env perl")
        append(line("."),"")
        append(line(".")+1, "use warnings;")
        append(line(".")+2, "use strict;")
        append(line(".")+3, "")
    endif
    # 新建文件后，自动定位到文件末尾
enddef
autocmd BufNewFile * normal G
