fun! CPPFormatSettings()
    setlocal equalprg=clang-format
endfun

autocmd FileType c,cpp call CPPFormatSettings()

" workaround: https://github.com/vim-jp/vim-cpp/issues/16
let c_no_curly_error = 1

" highlight class scope
let g:cpp_class_scope_highlight = 1
" highlight member variables
let g:cpp_member_variable_highlight = 1
" highlight class names in declarations
let g:cpp_class_decl_highlight = 1
" highlight POSIX functions
let g:cpp_posix_standard = 1
" highlight template functions
let g:cpp_experimental_template_highlight = 1
" highlight library concepts
let g:cpp_concepts_highlight = 1
