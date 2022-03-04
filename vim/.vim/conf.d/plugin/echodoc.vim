vim9script
# vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
# kate: space-indent on; indent-width 4;

# The command line is used to display echodoc text. This means that you will either need to set noshowmode or set cmdheight=2. Otherwise, the -- INSERT -- mode text will overwrite echodoc's text.
set noshowmode
g:echodoc_enable_at_startup = 1

g:echodoc#events = ['CompleteDone', 'CursorMovedI']
