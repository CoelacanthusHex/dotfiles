vim9script

def CPPFormatSettings()
    setlocal equalprg=clang-format
enddef

autocmd FileType c,cpp CPPFormatSettings()

# workaround: https://github.com/vim-jp/vim-cpp/issues/16
g:c_no_curly_error = 1

# highlight class scope
g:cpp_class_scope_highlight = 1
# highlight member variables
g:cpp_member_variable_highlight = 1
# highlight class names in declarations
g:cpp_class_decl_highlight = 1
# highlight POSIX functions
g:cpp_posix_standard = 1
# highlight template functions
g:cpp_experimental_template_highlight = 1
# highlight library concepts
g:cpp_concepts_highlight = 1
