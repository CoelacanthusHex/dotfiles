" vim: set sw=4 ts=8 sts=4 noexpandtab et foldmethod=marker:
" let g:racer_cmd = "~/.cargo/bin/racer"
let g:racer_experimental_completer = 1

autocmd FileType * :call RustChangeTabMapping()

function RustChangeTabMapping()
    if (&filetype == "rust")
        inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : SmartTab()
    endif
endfunction

function! SmartTab()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] == ' '
        return "\<TAB>"
    else
        echo "Completing"
        return "\<C-x>\<C-o>"
    endif
endfunction
