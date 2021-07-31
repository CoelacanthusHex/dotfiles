let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

au FileType gitcommit let b:EditorConfig_disable = 1
