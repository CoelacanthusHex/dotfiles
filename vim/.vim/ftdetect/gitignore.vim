scriptencoding utf-8

" Copyright (c) 2017-2020 Filip Szymański. All rights reserved.
" Use of this source code is governed by an MIT license that can be
" found in the LICENSE file.

" https://git-scm.com/docs/gitignore#_description
autocmd BufNewFile,BufRead */.config/git/ignore,*.git/info/exclude,.gitignore
      \ set filetype=gitignore

" vim: ts=2 et sw=2
