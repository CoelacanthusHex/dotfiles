""""""" Airline Configurations

let g:airline_powerline_fonts = 0
if $TERM != 'linux'
	let g:airline_symbols_ascii = 0
	let g:airline_theme='onedark'
else
	let g:airline_symbols_ascii = 1
	let g:airline_theme='base16_gruvbox_dark_hard'
endif

" 显示 buffer 编号
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#enabled = 1

" Enable Vim9 Script implementation
let g:airline_experimental = 1
