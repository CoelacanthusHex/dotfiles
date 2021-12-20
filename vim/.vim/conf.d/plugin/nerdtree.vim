" vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
" NERDTree Configuration

"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" 最后是个 window 是 NERDTree 时自动退出
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" kate: space-indent on; indent-width 4;
