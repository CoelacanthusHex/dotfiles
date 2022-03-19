vim9script
# vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
# kate: space-indent on; indent-width 4; syntax vim;

# SPDX-License-Identifier: MPL-2.0
# SPDX-FileCopyrightText: Coelacanthus

packadd jetpack

jetpack#begin('~/.vim/plugged')

    # Theme {{{
    jetpack#add('joshdick/onedark.vim')
    # Statusline
    jetpack#add('vim-airline/vim-airline')
    # Statusline theme
    jetpack#add('vim-airline/vim-airline-themes')
    # }}}
    
    # Misc {{{
    # Code format
    jetpack#add('sbdchd/neoformat')
    map <F5> :Neoformat <CR>
    # Git
    jetpack#add('tpope/vim-git')
    jetpack#add('tpope/vim-fugitive')
    # Git sign column
    jetpack#add('airblade/vim-gitgutter')
    # Fcitx
    if !has('win32') && !has("win64") && exists("$DBUS_SESSION_BUS_ADDRESS")
        jetpack#add('lilydjwg/fcitx.vim')
    endif
    # Indent guide
    jetpack#add('Yggdroot/indentLine')
    # Auto pairs
    jetpack#add('Raimondi/delimitMate')
    # Tagbar
    if executable('ctags')
        jetpack#add('majutsushi/tagbar')
    endif
    # Rainbow
    jetpack#add('91khr/rainbow')
    g:rainbow_active = 1
    # EditorConfig
    #jetpack#add('editorconfig/editorconfig-vim')
    # Color code
    #Jetpack 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
    # Auto detect indent size
    jetpack#add('tpope/vim-sleuth')
    # Unicode
    jetpack#add('chrisbra/unicode.vim')
    # Sudo support
    jetpack#add('tpope/vim-eunuch')
    # Snippets
    jetpack#add('SirVer/ultisnips')
    g:UltiSnipsSnippetDirectories = [$HOME .. '/.vim/UltiSnips']
    jetpack#add('tomtom/tcomment_vim')
    jetpack#add('skywind3000/asyncrun.vim')
    jetpack#add('andymass/vim-matchup')
    g:loaded_matchit = 1

    jetpack#add('tpope/vim-repeat')
    jetpack#add('tpope/vim-endwise')
    jetpack#add('Shougo/echodoc.vim')
    jetpack#add('Shougo/context_filetype.vim')

    jetpack#add('dense-analysis/ale', { 'for': ['sh', 'c', 'cpp', 'rust', 'python', 'go', 'tex'] })

    if executable('gtags') || executable('ctags')
        jetpack#add('vim-scripts/gtags.vim')
        jetpack#add('ludovicchabant/vim-gutentags')
    endif
    
    jetpack#add('gelguy/wilder.nvim')
    # Not need for we don't use fuzzy
    #jetpack#add('roxma/nvim-yarp')
    #jetpack#add('roxma/vim-hug-neovim-rpc')
    
    # For test
    jetpack#add('dstein64/vim-startuptime')
    # }}}

    # Auto-complete {{{
    if filereadable('/usr/share/vim/vimfiles/plugin/youcompleteme.vim')
        # Using YouCompleteMe when available
    elseif executable("deno")
        # Using ddc {{{
        jetpack#add('vim-denops/denops.vim')
        jetpack#add('Shougo/ddc.vim')
        
        # Sources {{{
        # Use around source.
        # https://github.com/Shougo/ddc-around
        jetpack#add('Shougo/ddc-around')
        jetpack#add('Shougo/neco-vim')
        jetpack#add('prabirshrestha/vim-lsp')
        jetpack#add('shun/ddc-vim-lsp')
        jetpack#add('mattn/vim-lsp-settings')
        jetpack#add('matsui54/denops-signature_help')
        jetpack#add('LumaKernel/ddc-file')
        jetpack#add('matsui54/ddc-buffer')
        jetpack#add('Shougo/ddc-zsh')
        jetpack#add('matsui54/ddc-dictionary')
        if executable('ctags')
            jetpack#add('delphinus/ddc-ctags')
        endif
        jetpack#add('Shougo/ddc-omni')
        jetpack#add('matsui54/ddc-ultisnips')

        # }}}

        # filters {{{
        jetpack#add('Shougo/ddc-matcher_head')
        jetpack#add('Shougo/ddc-sorter_rank')
        jetpack#add('matsui54/ddc-filter_editdistance')
        # }}}
            
        # }}}
    else
        # Using asyncomplete {{{
        jetpack#add('prabirshrestha/vim-lsp')
        jetpack#add('mattn/vim-lsp-settings')
        jetpack#add('prabirshrestha/asyncomplete.vim')
        jetpack#add('prabirshrestha/asyncomplete-lsp.vim')
        jetpack#add('prabirshrestha/asyncomplete-file.vim')
        jetpack#add('prabirshrestha/asyncomplete-buffer.vim')
        jetpack#add('hiterm/asyncomplete-look')
        jetpack#add('Shougo/neco-vim')
        jetpack#add('prabirshrestha/asyncomplete-necovim.vim')
        if executable('ctags')
            jetpack#add('prabirshrestha/asyncomplete-tags.vim')
            jetpack#add('ludovicchabant/vim-gutentags')
            autocmd User asyncomplete_setup asyncomplete#register_source({
                \ name: 'tags',
                \ allowlist: ['c'],
                \ completor: function('asyncomplete#sources#tags#completor'),
            \ })
        endif

        autocmd User asyncomplete_setup asyncomplete#register_source({
            \ name: 'file',
            \ allowlist: ['*'],
            \ priority: 10,
            \ completor: function('asyncomplete#sources#file#completor')
        \ })
        autocmd User asyncomplete_setup asyncomplete#register_source({
            \ name: 'buffer',
            \ allowlist: ['*'],
            \ blocklist: ['go'],
            \ priority: 10,
            \ completor: function('asyncomplete#sources#buffer#completor'),
            \ config: {
            \     max_buffer_size: 5000000,
            \ },
        \ })
        autocmd User asyncomplete_setup asyncomplete#register_source({
            \ name: 'look',
            \ allowlist: ['text', 'markdown', 'tex', 'gitcommit'],
            \ completor: function('asyncomplete#sources#look#completor'),
        \ })
        autocmd User asyncomplete_setup asyncomplete#register_source({
            \ name: 'necovim',
            \ allowlist: ['vim'],
            \ completor: function('asyncomplete#sources#necovim#completor'),
        \ })
        
        g:asyncomplete_auto_popup = 1
        g:lsp_diagnostics_enabled = 0
        # }}}
    endif
    # TODO: using vim9lsp
    #jetpack#add('yegappan/lsp')
    # }}}

    # Language {{{
    ######## C++
    jetpack#add('octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp'] })

    ######## CSV
    jetpack#add('chrisbra/csv.vim', { 'for': 'csv' })

    ######## CSV
    jetpack#add('vim-crystal/vim-crystal', { 'for': 'crystal' })

    ######## CSS && HTML
    jetpack#add('hail2u/vim-css3-syntax')
    jetpack#add('othree/html5.vim')
    
    ######## Qt
    jetpack#add('peterhoeg/vim-qml')
    jetpack#add('pboettch/vim-cmake-syntax')

    ######## Rust
    jetpack#add('cespare/vim-toml', { 'branch': 'main' })
    # Playpen integration
    jetpack#add('mattn/webapi-vim')
    jetpack#add('rust-lang/rust.vim', { 'for': 'rust' })
    #g:autofmt_autosave = 1
    # Cargo
    jetpack#add('timonv/vim-cargo')

    ######## Scala
    jetpack#add('derekwyatt/vim-scala', { 'for': 'scala' })
    jetpack#add('lfiolhais/vim-chisel')

    ######## Python
    jetpack#add('Vimjas/vim-python-pep8-indent', { 'for': 'python' })

    ######## Go
    jetpack#add('fatih/vim-go', { 'for': 'go' })
    
    ######## TypeScript
    jetpack#add('HerringtonDarkholme/yats.vim', { 'for': ['javescript', 'typescript'] })
    # https://thoughtbot.com/blog/modern-typescript-and-react-development-in-vim
    jetpack#add('pangloss/vim-javascript', { 'for': ['javescript', 'typescript'] })
    jetpack#add('jelera/vim-javascript-syntax', { 'for': ['javescript', 'typescript'] })
    jetpack#add('styled-components/vim-styled-components', { 'branch': 'main', 'for': ['javescript', 'typescript'] })
    jetpack#add('jparise/vim-graphql', { 'for': ['javescript', 'typescript'] })

    ######## Markdown
    jetpack#add('godlygeek/tabular', { 'for': 'markdown' })
    jetpack#add('plasticboy/vim-markdown', { 'for': 'markdown' })

    ######## Vim Script
    jetpack#add('Shougo/neco-vim', { 'for': 'vim' })

    ######## Haskell
    jetpack#add('neovimhaskell/haskell-vim', { 'for': 'haskell' })

    ######## LaTeX
    jetpack#add('lervag/vimtex', { 'for': ['tex', 'latex'] })

    ######## Nginx
    jetpack#add('chr4/nginx.vim')

    ######## systemd files
    jetpack#add('Matt-Deacalion/vim-systemd-syntax')

    ######## Beancount
    jetpack#add('nathangrigg/vim-beancount')

    ######## Nftables
    jetpack#add('nfnty/vim-nftables')

    ######## Kitty
    jetpack#add('fladson/vim-kitty')
    
    ######## GNU
    jetpack#add('mattkretz/vim-gnuindent')
    
    ######## Kotlin
    jetpack#add('udalov/kotlin-vim', { 'for': 'kotlin' })
    
    ######## GLSL
    jetpack#add('tikhomirov/vim-glsl', { 'for': 'glsl' })

    ######## Others
    jetpack#add('rhysd/vim-syntax-codeowners')
    #}}}
jetpack#end()

if jetpack#tap('ddc.vim')
    ddc#custom#patch_global('sources', ['around', 'neco-vim', 'vim-lsp', 'file', 'buffer', 'zsh', 'dictionary', 'ctags', 'omni', 'ultisnips'])
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
        \ 'smartCase': v:true,
        \ }
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
        \   'forceCompletionPattern': "\\.|:\\s*|->",
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
        \ })

    # Customize settings on a filetype
    ddc#custom#patch_filetype(['c', 'cpp', 'rust'], {
        \ 'sources': ['vim-lsp', 'around', 'buffer'],
        \ 'sourceParams': {
        \   'vim-lsp': {
        \     'ignoreCompleteProvider': v:true,
        \   },
        \ },
        \ })
    #autocmd FileType c,cpp signature_help#enable()
    #g:lsp_signature_help_enabled = 0
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
endif

wilder#setup({
    'modes': [':', '/', '?'],
    'enable_cmdline_enter': 0,
})
wilder#set_option('pipeline', [
    wilder#branch(
        wilder#cmdline_pipeline(),
        wilder#search_pipeline(),
    ),
])
wilder#set_option('renderer', wilder#popupmenu_renderer({
    'highlighter': wilder#basic_highlighter(),
}))

# https://github.com/ycm-core/YouCompleteMe/issues/36#issuecomment-171966710
def g:UltiSnips_Complete(): string
    UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
                return "\<TAB>"
            endif
        endif
    endif
    return ""
enddef

def g:UltiSnips_Reverse(): string
    UltiSnips#JumpBackwards()
    if g:ulti_jump_backwards_res == 0
        return "\<C-P>"
    endif

    return ""
enddef


if !exists("g:UltiSnipsJumpForwardTrigger")
    g:UltiSnipsJumpForwardTrigger = "<tab>"
endif

if !exists("g:UltiSnipsJumpBackwardTrigger")
    g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
endif

autocmd InsertEnter * exec "inoremap <silent> " .. g:UltiSnipsExpandTrigger .. " <C-R>=g:UltiSnips_Complete()<cr>"
autocmd InsertEnter * exec "inoremap <silent> " .. g:UltiSnipsJumpBackwardTrigger .. " <C-R>=g:UltiSnips_Reverse()<cr>"
