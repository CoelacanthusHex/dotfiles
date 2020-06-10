" ALE Configuration

" Disable the completion for vim-go, we have ale
let g:go_code_completion_enabled = 0
let g:ale_linters = {
            \ 'cpp': ['ccls'],
            \ 'rust': ['analyzer', 'cargo', 'rls'],
            \ 'go': ['gopls'],
            \ 'tex': ['texlab'],
            \ 'yaml': ['yamllint'],
            \ 'sh': ['shellcheck']
            \ }
let g:ale_cpp_ccls_init_options = {
            \   'cache': {
            \       'directory': '/tmp/ccls/cache',
            \   },
            \ }
"let g:ale_completion_enabled = 1

autocmd FileType * :call CheckIfToggleALEShortCut()

function CheckIfToggleALEShortCut() 
    if (&filetype == "cpp" || &filetype == "rust")
        nnoremap <C-]>] :ALEGoToDefinition<CR> 
    endif
    "inoremap <silent><expr><TAB>  pumvisible() ? "\<C-n>" : SmartTab()
endfunction

function! SmartTab()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] == ' '
        return "\<TAB>"
    else
        return deoplete#complete()
    endif
endfunction

" NOTE: You need to have the following dependencies for language completion
" support:
" c/cpp: ccls
" rust: rust-analyzer
" go: gopls
