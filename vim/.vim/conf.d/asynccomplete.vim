vim9script
# vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
# kate: space-indent on; indent-width 4; syntax vim;

# SPDX-License-Identifier: MPL-2.0
# SPDX-FileCopyrightText: Coelacanthus

inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
# To auto close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

g:asyncomplete_auto_completeopt = 0
set completeopt=menuone,noinsert,noselect,popup

g:UltiSnipsExpandTrigger       = "<NUL>"
g:UltiSnipsListSnippets        = "<NUL>"
g:UltiSnipsJumpForwardTrigger  = "<NUL>"
g:UltiSnipsJumpBackwardTrigger = "<NUL>"
g:UltiSnipsSnippetDirectories  = [$HOME .. '/.vim/UltiSnips']

autocmd User asyncomplete_setup asyncomplete#register_source(asyncomplete#sources#necovim#get_source_options({
    \ 'name': 'necovim',
    \ 'allowlist': ['vim'],
    \ 'completor': function('asyncomplete#sources#necovim#completor'),
    \ }))
autocmd User asyncomplete_setup asyncomplete#register_source({
    \ 'name': 'gitcommit',
    \ 'whitelist': ['gitcommit'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#gitcommit#completor')
    \ })
autocmd User asyncomplete_setup asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'allowlist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))
autocmd User asyncomplete_setup asyncomplete#register_source({
    \ 'name': 'look',
    \ 'allowlist': ['text', 'markdown', 'gitcommit'],
    \ 'completor': function('asyncomplete#sources#look#completor'),
    \ })
autocmd User asyncomplete_setup asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'allowlist': ['*'],
    \ 'blocklist': ['go'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ 'config': {
    \    'max_buffer_size': 5000000,
    \  },
    \ }))

#g:asyncomplete_preprocessor = [function('asyncomplete#preprocessor#ezfilter#filter')]
#autocmd User asyncomplete_setup call asyncomplete#register_source(
#    \ asyncomplete#sources#unicodesymbol#get_source_options({
#    \   'name': 'unicodesymbol',
#    \   'whitelist': ['julia'],
#    \   'completor': function('asyncomplete#sources#unicodesymbol#completor'),
#    \ }))
#g:asyncomplete#preprocessor#ezfilter#config = {}
#g:asyncomplete#preprocessor#ezfilter#config.unicodesymbol =
#    \ {ctx, items -> filter(items, 'ctx.match(v:val.menu)')}
