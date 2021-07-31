" ALE Configuration

" Disable the completion for vim-go, we have ale
let g:go_code_completion_enabled = 0
let g:ale_linters = {
            \ 'asm': ['gcc'],
            \ 'c': ['ccls', 'clangd', 'gcc', 'cppcheck'],
            \ 'cpp': ['ccls', 'clangd', 'gcc', 'cppcheck'],
            \ 'rust': ['analyzer', 'cargo', 'rls'],
            \ 'go': ['gopls'],
            \ 'tex': ['texlab'],
            \ 'yaml': ['yamllint'],
            \ 'mail': ['languagetool'],
            \ 'json': ['jq'],
            \ 'javascript': ['eslint', 'tsserver'],
            \ 'haskell': ['hls', 'ghc'],
            \ 'sh': ['shellcheck']
            \ }
let g:ale_cpp_ccls_init_options = {
            \   'cache': {
            \       'directory': '/tmp/ccls/cache',
            \   },
            \ }

let g:ale_c_gcc_options = '-Wall -O2 -std=c11'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++17'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''


"let g:ale_completion_enabled = 1
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:airline#extensions#ale#enabled = 1
let g:ycm_show_diagnostics_ui = 0
" 规定了如果 normal 模式下文字改变以及离开 insert 模式的时候运行 linter，这是相对保守的做法，如果没有的话，会导致 YouCompleteMe 的补全对话框频繁刷新。
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

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
