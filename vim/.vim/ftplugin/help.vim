" vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
" kate: space-indent on; indent-width 4; syntax vim;

" Set indention & spelling when editing help files ><
setlocal autoindent
" No space check: they're used for formatting ><
let b:spacecheck_disabled = v:true
" If writing doc, enable spell check ><
if !&ro
    setlocal spell
endif
