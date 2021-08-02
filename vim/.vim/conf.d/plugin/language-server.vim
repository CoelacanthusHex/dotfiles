" vim: set sw=4 ts=4 sts=4 et foldmethod=marker spell:
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