" vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
" Vim-go Configuration

let g:go_bin_path = "/usr/bin"
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
let g:go_highlight_functions = 1
let g:go_highlight_fields = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
