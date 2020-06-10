" deoplete Configuration

" 自动启动
let g:deoplete#enable_at_startup = 1
"let g:deoplete#profile = 1

"call deoplete#enable_logging('DEBUG', 'deoplete.log')
"call deoplete#enable_logging('INFO', '/tmp/'.$USER.'_deoplete.log')

"call deoplete#custom#option('sources', {
"    \ '_': ['ale'],
"    \})

call deoplete#enable()
