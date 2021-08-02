" vim: set sw=4 ts=4 sts=4 et foldmethod=marker spell:
""""""""""""""""""""""""""""""""""""" 新文件标题

" 新建.c,.h,.sh,.java文件，自动插入文件头
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.pl,*.java,*.py exec ":call SetTitle()"
"" 定义函数SetTitle，自动插入文件头
func SetTitle()
    " 如果文件类型为.sh文件
    if &filetype == 'sh'
        call setline(1, "\#!/bin/bash")
        call append(line("."), "")
    elseif &filetype == 'python'
        call setline(1, "#!/usr/bin/env python")
        call append(line("."), "# coding=utf-8")
        call append(line(".")+1, "")

    elseif &filetype == 'ruby'
        call setline(1, "#!/usr/bin/env ruby")
        call append(line("."),"# encoding: utf-8")
        call append(line(".")+1, "")

    elseif &filetype == 'perl'
        call setline(1,"#!/usr/bin/env perl")
        call append(line("."),"")
        call append(line(".")+1, "use warnings;")
        call append(line(".")+2, "use strict;")
        call append(line(".")+3, "")

    else
        call setline(1, "/*************************************************************************")
        call append(line("."), "	> File Name: ".expand("%"))
        call append(line(".")+1, "	> Author: ")
        call append(line(".")+2, "	> Mail: ")
        call append(line(".")+3, "	> Created Time: ".strftime("%c"))
        call append(line(".")+4, " ************************************************************************/")
        call append(line(".")+5, "")
    endif
    if expand("%:e") == 'cpp'
        call append(line(".")+6, "#include <iostream>")
        call append(line(".")+7, "int main() {")
        call append(line(".")+8, "    ")
        call append(line(".")+9, "    return 0;")
        call append(line(".")+10, "}")
    endif
    if &filetype == 'c'
        call append(line(".")+6, "#include <stdio.h>")
        call append(line(".")+7, "int main() {")
        call append(line(".")+8, "    ")
        call append(line(".")+9, "    return 0;")
        call append(line(".")+10, "}")
    endif
    if expand("%:e") == 'h'
        call append(line(".")+6, "#ifndef _".toupper(expand("%:r"))."_H")
        call append(line(".")+7, "#define _".toupper(expand("%:r"))."_H")
        call append(line(".")+8, "#endif")
    endif
    if &filetype == 'java'
        call append(line(".")+6, "public class ".expand("%:r"))
        call append(line(".")+7, "")
    endif
    " 新建文件后，自动定位到文件末尾
endfunc
autocmd BufNewFile * normal G
