let b:beancount_root = '~/accounting'
autocmd FileType beancount inoremap . .<C-O>:AlignCommodity<CR>
autocmd FileType beancount inoremap <Tab> <c-x><c-o>
