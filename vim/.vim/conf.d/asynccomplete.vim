vim9script
# vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
# kate: space-indent on; indent-width 4; syntax vim;

# SPDX-License-Identifier: MPL-2.0
# SPDX-FileCopyrightText: Coelacanthus

g:UltiSnipsExpandTrigger       = "<NUL>"
g:UltiSnipsListSnippets        = "<NUL>"
g:UltiSnipsJumpForwardTrigger  = "<NUL>"
g:UltiSnipsJumpBackwardTrigger = "<NUL>"
g:UltiSnipsSnippetDirectories  = [$HOME .. '/.vim/UltiSnips']

au User asyncomplete_setup asyncomplete#register_source(asyncomplete#sources#necovim#get_source_options({
    \ 'name': 'necovim',
    \ 'allowlist': ['vim'],
    \ 'completor': function('asyncomplete#sources#necovim#completor'),
    \ }))
au User asyncomplete_setup asyncomplete#register_source({
    \ 'name': 'gitcommit',
    \ 'whitelist': ['gitcommit'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#gitcommit#completor')
    \ })
au User asyncomplete_setup asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'allowlist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))
au User asyncomplete_setup asyncomplete#register_source({
    \ 'name': 'look',
    \ 'allowlist': ['text', 'markdown', 'gitcommit'],
    \ 'completor': function('asyncomplete#sources#look#completor'),
    \ })
au User asyncomplete_setup asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'allowlist': ['*'],
    \ 'blocklist': ['go'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ 'config': {
    \    'max_buffer_size': 5000000,
    \  },
    \ }))