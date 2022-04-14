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
    \   'bufNameStyle': 'basename',
    \ },
    \ 'dictionary': {
    \   'dictPaths': [
    \     '/usr/share/dict/usa',
    \     '/usr/share/dict/british'
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
    \   'sorters': ['sorter_rank'],
    \   'converters': ['converter_remove_overlap'],
    \ },
    \ 'around': {
    \   'mark': 'around',
    \   'matchers': ['matcher_head', 'matcher_length'],
    \ },
    \ 'buffer': {
    \   'mark': 'buffer',
    \ },
    \ 'ctags': {
    \   'mark': 'ctags',
    \   'forceCompletionPattern': '\.\w*|:\w*|->\w*',
    \ },
    \ 'cmdline': {
    \   'mark': 'cmd',
    \   'forceCompletionPattern': "\\s|/|-", 
    \   'minAutoCompleteLength': 1,
    \ },
    \ 'cmdline-history': {
    \   'mark': 'history',
    \   'matchers': ['matcher_head'], 
    \   'sorters': [], 
    \   'minAutoCompleteLength': 1,
    \   'maxItems': 3,
    \ },
    \ 'dictionary': {
    \   'mark': 'dict',
    #\   'matchers': ['matcher_editdistance', 'matcher_fuzzy'],
    \   'sorters': [], 
    \   'converters': ['converter_fuzzy'],
    \   'maxItems': 10,
    \   'minAutoCompleteLength': 3,
    \ },
    \ 'emoji': {
    \   'mark': 'emoji',
    \   'dup': v:true, 
    \   'matcherKey': 'kind',
    \   'minAutoCompleteLength': 1,
    \ },
    \ 'file': {
    \   'mark': 'file',
    \   'isVolatile': v:true,
    \   'forceCompletionPattern': '\S/\S*',
    \ },
    \ 'necovim': {
    \   'mark': 'neco',
    \ },
    \ 'omni': {
    \   'mark': 'omni',
    \ },
    \ 'skkeleton': {
    \   'mark': 'skk',
    \   'matchers': ['skkeleton'],
    \   'sorters': [],
    \   'minAutoCompleteLength': 2,
    \ },
    \ 'ultisnips': {
    \   'mark': 'snippet',
    \ },
    \ 'vim-lsp': {
    \   'mark': 'lsp',
    \   'dup': v:true,
    \   'matchers': ['matcher_head'],
    \   'forceCompletionPattern': '\.\w*|:\w*|::\w*|->\w*',
    \   'minAutoCompleteLength': 1,
    \ },
    \ 'zsh': {
    \   'mark': 'zsh',
    \ },
    \ })

ddc#custom#patch_global('filterParams', {
      \ 'matcher_editdistance': {
      \   'showScore': v:true,
      \   'limit': 10
      \ },
      \ })

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
    \ 'sources': ['around', 'file', 'buffer', 'dictionary'],
    \ })
ddc#custom#patch_filetype(['gitcommit'], {
    \ 'sources': ['around', 'file', 'buffer', 'dictionary', 'git-file', 'git-commit', 'git-branch'],
    \ })
ddc#custom#patch_filetype(['snippets'], {
    \ 'sources': ['ultisnips'],
    \ })
ddc#custom#patch_filetype(['zsh'], {
    \ 'sources': ['zsh', 'buffer', 'around', 'file'],
    \ })
ddc#custom#patch_filetype('markdown', 'sourceParams', {
    \ 'around': {
    \   'maxSize': 100
    \ },
    \ })
ddc#custom#patch_filetype(['vim'], 
    \ 'sources', ['necovim', 'around', 'file']
    \ )
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
inoremap <silent><expr> <C-l>   ddc#map#extend()

# Use ddc.
ddc#enable()
