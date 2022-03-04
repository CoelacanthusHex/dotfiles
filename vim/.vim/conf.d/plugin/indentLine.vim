vim9script
# vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
# kate: space-indent on; indent-width 4;

# https://stackoverflow.com/questions/40601818/vim-displays-json-file-without-any-quotes
# https://github.com/Yggdroot/indentLine
# https://vi.stackexchange.com/questions/7258/how-do-i-prevent-vim-from-hiding-symbols-in-markdown-and-json
autocmd Filetype json 'g:indentLine_setConceal = 0'
autocmd Filetype json 'g:vim_json_syntax_conceal = 0'
autocmd Filetype json 'setlocal conceallevel=0'
