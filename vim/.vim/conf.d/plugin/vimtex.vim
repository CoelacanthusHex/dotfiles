" vim: set sw=4 ts=8 sts=4 et foldmethod=marker:

let g:vimtex_enabled = 1
let g:vimtex_fold_enabled = 1
let g:vimtex_compiler_latexmk = {
            \     'options' : [
            \       '-xelatex',
            \       '-shell-escape',
            \     ],
            \ }
let g:tex_flavor = 'latex'
