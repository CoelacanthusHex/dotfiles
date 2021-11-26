" vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
" mkdx Configuration

" https://github.com/SidOfc/mkdx/issues/151#issuecomment-846188322
" https://vi.stackexchange.com/questions/7258/how-do-i-prevent-vim-from-hiding-symbols-in-markdown-and-json
call mkdx#configure({ 
                    \ 'highlight': { 'enable': 1 },
                    \ 'enter': { 'shift': 1 },
                    \ 'links': { 
                        \ 'external': { 
                            \ 'enable': 1,
                            \ 'conceal': 1
                            \ }
                        \ },
                    \ 'toc': { 
                        \ 'text': 'Table of Contents', 
                        \ 'update_on_write': 1
                        \ },
                    \ 'fold': { 'enable': 1 } })
" for vim-polyglot users, it loads Plasticboy's markdown
" plugin which unfortunately interferes with mkdx list indentation.
let g:polyglot_disabled = ['markdown']

" https://github.com/SidOfc/mkdx/issues/138
" hack for URL is not visible
let g:indentLine_concealcursor=""
let g:indentLine_conceallevel=2
