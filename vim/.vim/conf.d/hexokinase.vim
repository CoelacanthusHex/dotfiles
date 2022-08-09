vim9script
# vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
# kate: space-indent on; indent-width 4;

g:Hexokinase_highlighters = ['backgroundfull']
g:Hexokinase_refreshEvents = ['TextChanged', 'InsertLeave']

command! HexokinaseToggle packadd vim-hexokinase | HexokinaseToggle
