" vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
" kate: space-indent on; indent-width 4; syntax vim;

" Senioria would often type chars triggering foldings qwq><
setlocal nofoldenable
" Make text flow and be prettier~ w
setlocal formatoptions+=aw
" No space check: flow will have trailing spaces as continuation ><
let b:spacecheck_disabled = v:true
