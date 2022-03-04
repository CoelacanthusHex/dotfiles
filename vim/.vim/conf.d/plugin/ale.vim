vim9script
# vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
# kate: space-indent on; indent-width 4;
# ALE Configuration

# Disable the completion for vim-go, we have ale
g:go_code_completion_enabled = 0
g:ale_linters = {
            'asm': ['gcc'],
            'c': ['ccls', 'clangd', 'gcc', 'clangtidy', 'cppcheck'],
            'cpp': ['ccls', 'clangd', 'gcc', 'clangtidy', 'cppcheck'],
            'rust': ['analyzer', 'cargo', 'rls'],
            'go': ['gopls'],
            'tex': ['texlab'],
            'yaml': ['yamllint'],
            'mail': ['languagetool'],
            'json': ['jq'],
            'javascript': ['eslint', 'tsserver'],
            'haskell': ['hls', 'ghc'],
            'sh': ['shellcheck']
            }
g:ale_c_ccls_init_options = {
            'cache': {
                'directory': '/tmp/ccls/cache',
            },
            }
g:ale_cpp_ccls_init_options = {
            'cache': {
                'directory': '/tmp/ccls/cache',
            },
            }

g:ale_c_gcc_options = '-Wall -O2 -std=c11'
g:ale_cpp_gcc_options = '-Wall -O2 -std=c++17'
g:ale_c_cppcheck_options = ''
g:ale_cpp_cppcheck_options = ''


#g:ale_completion_enabled = 1
g:ale_echo_msg_error_str = 'E'
g:ale_echo_msg_warning_str = 'W'
g:ale_echo_msg_format = '[%linter%] %code: %%s [%severity%]'
g:airline#extensions#ale#enabled = 1
g:ycm_show_diagnostics_ui = 0
# 规定了如果 normal 模式下文字改变以及离开 insert 模式的时候运行 linter，这是相对保守的做法，如果没有的话，会导致 YouCompleteMe 的补全对话框频繁刷新。
g:ale_lint_on_text_changed = 'normal'
g:ale_lint_on_insert_leave = 1

autocmd FileType * CheckIfToggleALEShortCut()

def CheckIfToggleALEShortCut() 
    if (&filetype == "cpp" || &filetype == "rust")
        nnoremap <C-]>] :ALEGoToDefinition<CR> 
    endif
    #inoremap <silent><expr><TAB>  pumvisible() ? "\<C-n>" : SmartTab()
enddef

# NOTE: You need to have the following dependencies for language completion
# support:
# c/cpp: ccls
# rust: rust-analyzer rls
# go: gopls
# python: pyright
