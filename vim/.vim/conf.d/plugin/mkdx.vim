" vim: set sw=4 ts=4 sts=4 et foldmethod=marker spell:
" mkdx Configuration

let g:mkdx#settings     = { 'highlight': { 'enable': 1 },
                    \ 'enter': { 'shift': 1 },
                    \ 'links': { 'external': { 'enable': 1 } },
                    \ 'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },
                    \ 'fold': { 'enable': 0 } }
" for vim-polyglot users, it loads Plasticboy's markdown
" plugin which unfortunately interferes with mkdx list indentation.
let g:polyglot_disabled = ['markdown']
