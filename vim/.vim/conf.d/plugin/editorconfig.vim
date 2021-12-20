" vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

au FileType gitcommit let b:EditorConfig_disable = 1
" kate: space-indent on; indent-width 4;
