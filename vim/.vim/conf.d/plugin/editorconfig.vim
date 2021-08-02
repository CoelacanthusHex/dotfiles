" vim: set sw=4 ts=4 sts=4 et foldmethod=marker spell:
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

au FileType gitcommit let b:EditorConfig_disable = 1
