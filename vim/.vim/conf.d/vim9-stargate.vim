vim9script
# vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
# kate: space-indent on; indent-width 4;

noremap <M-q>f <Cmd>call stargate#OKvim(1)<CR>
noremap <M-q>F <Cmd>call stargate#OKvim(1)<CR>
noremap <M-q>j <Cmd>call stargate#OKvim('^\s*\zs')<CR>
noremap <M-q>k <Cmd>call stargate#OKvim('^\s*\zs')<CR>
g:stargate_ignorecase = false
g:stargate_chars = 'fjdklshgaewiomc;rtyupqnvbxz'
