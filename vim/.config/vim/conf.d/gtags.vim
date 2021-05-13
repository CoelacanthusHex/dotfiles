" This is the configuration file for GNU GLOBAL vim plugin

nmap <F2> :copen<CR>
nmap <F4> :cclose<CR>
nmap <F5> :Gtags<SPACE>
nmap <F6> :Gtags -f %<CR>
nmap <F7> :GtagsCursor<CR>
nmap <F8> :Gozilla<CR>
nmap <C-j> :cn<CR>
nmap <C-k> :cp<CR>
nmap <C-]>] :GtagsCursor<CR>
let g:Gtags_OpenQuickfixWindow = 1
