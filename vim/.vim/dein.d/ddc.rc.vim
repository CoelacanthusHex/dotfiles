vim9script
# vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
# kate: space-indent on; indent-width 4; syntax vim;

# SPDX-License-Identifier: MPL-2.0
# SPDX-FileCopyrightText: Coelacanthus

ddc#custom#patch_global('sources', ['around', 'vim-lsp', 'file', 'buffer', 'ctags', 'ultisnips'])
ddc#custom#patch_global('backspaceCompletion', v:true)
ddc#custom#patch_global('sourceParams', {
    \ 'around': {'maxSize': 500},
    \ 'buffer': {
    \   'requireSameFiletype': v:false,
    \   'limitBytes': 5000000,
    \   'fromAltBuf': v:true,
    \   'forceCollect': v:true,
    \ },
    \ 'dictionary': {
    \   'dictPaths': [
    \     '/usr/share/dict/usa',
    \      '/usr/share/dict/british'
    \   ],
    \   'smartCase': v:true,
    \ },
    \ 'vim-lsp': {
    \   'ignoreCompleteProvider': v:true,
    \   },
    \ })

ddc#custom#patch_global('sourceOptions', {
    \ '_': {
    \   'matchers': ['matcher_head'],
    \   'sorters': ['sorter_rank']
    \ },
    \ 'dictionary': {
    \   'mark': 'dict',
    \   'matchers': ['matcher_editdistance'],
    \   'sorters': [], 
    \ },
    \ 'vim-lsp': {
    \   'mark': 'lsp',
    \   'dup': v:true,
    \   'matchers': ['matcher_head'],
    \   'forceCompletionPattern': '\.\w*|:\w*|->\w*',
    \   'minAutoCompleteLength': 1,
    \ },
    \ 'zsh': {
    \   'mark': 'zsh'
    \ },
    \ 'buffer': {
    \   'mark': 'buffer'
    \ },
    \ 'omni': {
    \   'mark': 'omni'
    \ },
    \ 'ultisnips': {
    \   'mark': 'snippet'
    \ },
    \ 'file': {
    \   'mark': 'file',
    \   'isVolatile': v:true,
    \   'forceCompletionPattern': '\S/\S*',
    \ },
    \ 'around': {'mark': 'around'},
    \ 'ctags': {'mark': 'ctags'},
    \ 'necovim': {'mark': 'neco'},
    \ })

# Customize settings on a filetype
ddc#custom#patch_filetype(['c', 'cpp', 'rust'], {
    \ 'sources': ['vim-lsp', 'around', 'buffer'],
    \ 'sourceOptions': {
    \   'vim-lsp': {
    \     'mark': 'lsp',
    \     'dup': v:true,
    \     'matchers': ['matcher_head'],
    \     'forceCompletionPattern': '\.\w*|:\w*|->\w*',
    \     'minAutoCompleteLength': 1,
    \   },
    \ }
    \ })
ddc#custom#patch_filetype(['help', 'markdown', 'tex', 'gitcommit'], {
    \ 'sources': ['around', 'dictionary'],
    \ })
ddc#custom#patch_filetype(['snippets'], {
    \ 'sources': ['ultisnips'],
    \ })
ddc#custom#patch_filetype(['zsh'], {
    \ 'sources': ['zsh', 'buffer', 'around', 'file', 'dictionary'],
    \ })
ddc#custom#patch_filetype('markdown', 'sourceParams', {
    \ 'around': {
    \   'maxSize': 100
    \ },
    \ })
ddc#custom#patch_filetype(['ps1', 'dosbatch', 'autohotkey', 'registry'], {
    \ 'sourceOptions': {
    \   'file': {
    \     'forceCompletionPattern': '\S\\\S*',
    \   },
    \ },
    \ 'sourceParams': {
    \   'file': {
    \     'mode': 'win32',
    \   },
    \ }})
# Mappings

# <TAB>: completion.
inoremap <expr><TAB>
    \ ddc#map#pum_visible() ? '<C-n>' :
    \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
    \ '<TAB>' : ddc#map#manual_complete()

# <S-TAB>: completion back.
inoremap <expr><S-TAB>  ddc#map#pum_visible() ? '<C-p>' : '<C-h>'

# Use ddc.
ddc#enable()
