" vim: set sw=4 ts=4 sts=4 et foldmethod=marker:
" The command line is used to display echodoc text. This means that you will either need to set noshowmode or set cmdheight=2. Otherwise, the -- INSERT -- mode text will overwrite echodoc's text.
set noshowmode
let g:echodoc_enable_at_startup = 1

let g:echodoc#events = ['CompleteDone', 'CursorMovedI']
