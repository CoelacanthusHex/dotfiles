" https://stackoverflow.com/questions/40601818/vim-displays-json-file-without-any-quotes
" https://github.com/Yggdroot/indentLine
" https://vi.stackexchange.com/questions/7258/how-do-i-prevent-vim-from-hiding-symbols-in-markdown-and-json
autocmd Filetype json
  \ let g:indentLine_setConceal = 0 |
  \ let g:vim_json_syntax_conceal = 0 |
  \ setlocal conceallevel=0
" kate: space-indent on; indent-width 4;
