" vim: set sw=4 ts=4 sts=4 et foldmethod=marker spell:
let b:beancount_root = '~/accounting'
autocmd FileType beancount inoremap . .<C-O>:AlignCommodity<CR>
autocmd FileType beancount inoremap <Tab> <c-x><c-o>
