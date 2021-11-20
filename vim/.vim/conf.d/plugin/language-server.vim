" vim: set sw=4 ts=8 sts=4 noexpandtab et foldmethod=marker:
" Language Server Configuration

let g:ycm_language_server =
  \ [
  \   {
  \     'name': 'latex',
  \     'cmdline': [ 'texlab' ],
  \     'filetypes': [ 'latex' ]
  \   },
  \   {
  \     'name': 'tex',
  \     'cmdline': [ 'texlab' ],
  \     'filetypes': [ 'tex' ]
  \   }
  \ ]
