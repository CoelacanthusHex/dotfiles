" vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
let g:ycm_semantic_triggers =  {
            \ 'c' : ['->', '.', 're!\w{3}'],
            \ 'objc': ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s', 're!\[.*\]\s'],
            \ 'ocaml' : ['.', '#', 're!\w{3}'],
            \ 'cpp,objcpp,cuda' : ['->', '.', '::', 're!\w{3}'],
            \ 'perl' : ['->', 're!\w{3}'],
            \ 'php' : ['->', '::', 're!\w{3}'],
            \ 'cs,d,elixir,go,groovy,java,javascript,julia,perl6,python,scala,typescript,vb' : ['.', 're!\w{3}'],
            \ 'ruby,rust' : ['.', '::', 're!\w{3}'],
            \ 'lua' : ['.', ':', 're!\w{3}'],
            \ 'erlang' : [':', 're!\w{3}'],
            \ }

let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0

" 语法关键字、注释、字符串补全
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
" 从注释、字符串、tag文件中收集用于补全信息
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1

set completeopt+=menu
set completeopt+=menuone
let g:ycm_add_preview_to_completeopt = 0

let g:ycm_show_diagnostics_ui = 0  " 禁用YCM自带语法检查(使用ale)

" avoid automatically adding header files after complete in Youcompleteme
" I don't know why but it break completion
"let g:ycm_clangd_args=['--header-insertion=never']

nnoremap <leader>dc :YcmCompleter GoToDeclaration<cr>
nnoremap <leader>df :YcmCompleter GoToDefinition<cr>
nnoremap <leader>i :YcmCompleter GoToInclude<cr>nnoremap <leader>fi :YcmCompleter FixIt<cr>

let airline#extensions#ycm#enabled = 1
" kate: space-indent on; indent-width 4;
