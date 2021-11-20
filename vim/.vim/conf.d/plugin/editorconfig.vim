" vim: set sw=4 ts=8 sts=4 noexpandtab et foldmethod=marker:
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

au FileType gitcommit let b:EditorConfig_disable = 1
