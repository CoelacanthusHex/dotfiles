vim9script
# vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
# kate: space-indent on; indent-width 4;

# Vim-go Configuration

g:go_bin_path = "/usr/bin"
autocmd FileType go nmap <Leader>gd <Plug>(go-doc)
autocmd FileType go nmap <Leader>s <Plug>(go-implements)
autocmd FileType go nmap <Leader>gb <Plug>(go-doc-browser)
g:go_highlight_functions = 1
g:go_highlight_fields = 1
g:go_highlight_methods = 1
g:go_highlight_structs = 1
g:go_highlight_interfaces = 1
g:go_highlight_operators = 1
g:go_highlight_build_constraints = 1
