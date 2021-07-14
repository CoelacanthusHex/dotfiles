let g:ycm_semantic_triggers =  {
			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{3}'],
			\ 'cs,lua,javascript': ['re!\w{3}'],
			\ }

set completeopt=menu,menuone
let g:ycm_add_preview_to_completeopt = 0

let airline#extensions#ycm#enabled = 1
