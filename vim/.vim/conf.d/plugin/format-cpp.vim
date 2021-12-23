fun! CPPFormatSettings()
    setlocal equalprg=clang-format
endfun

autocmd FileType c,cpp call CPPFormatSettings()
