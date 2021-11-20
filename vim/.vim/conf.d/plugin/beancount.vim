" vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
let b:beancount_root = '~/accounting'
autocmd FileType beancount inoremap . .<C-O>:AlignCommodity<CR>
autocmd FileType beancount inoremap <Tab> <c-x><c-o>
