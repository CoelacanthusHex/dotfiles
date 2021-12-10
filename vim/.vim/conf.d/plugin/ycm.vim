" vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
let g:ycm_semantic_triggers =  {
            \ 'c' : ['->', '.', 're!\w{3}'],
            \ 'objc' : ['->', '.', 're!\w{3}'],
            \ 'ocaml' : ['.', '#', 're!\w{3}'],
            \ 'cpp,objcpp' : ['->', '.', '::', 're!\w{3}'],
            \ 'perl' : ['->', 're!\w{3}'],
            \ 'php' : ['->', '::', 're!\w{3}'],
            \ 'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go' : ['.', 're!\w{3}'],
            \ 'ruby' : ['.', '::', 're!\w{3}'],
            \ 'lua' : ['.', ':', 're!\w{3}'],
            \ 'erlang' : [':', 're!\w{3}'],
            \ }

let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0

set completeopt=menu,menuone
let g:ycm_add_preview_to_completeopt = 0

nnoremap <leader>dc :YcmCompleter GoToDeclaration<cr>
nnoremap <leader>df :YcmCompleter GoToDefinition<cr>
nnoremap <leader>i :YcmCompleter GoToInclude<cr>nnoremap <leader>fi :YcmCompleter FixIt<cr>

let airline#extensions#ycm#enabled = 1
