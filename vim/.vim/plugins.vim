vim9script
# vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
# kate: space-indent on; indent-width 4; syntax vim;

# SPDX-License-Identifier: MPL-2.0
# SPDX-FileCopyrightText: Coelacanthus

packadd jetpack

var vim_cache = expand('~/.cache/vim')
if !isdirectory(vim_cache)
    mkdir(vim_cache, 'p')
endif
var vim_data = expand('~/.local/share/vim')
if !isdirectory(vim_data)
    mkdir(vim_data, 'p')
endif

jetpack#begin()

jetpack#add('tani/vim-jetpack', {'opt': 1})

# Tools {{{
jetpack#add('vim-airline/vim-airline')
jetpack#add('vim-airline/vim-airline-themes', { depends: ['vim-airline/vim-airline'] })
jetpack#add('tpope/vim-fugitive')
jetpack#add('airblade/vim-gitgutter')
jetpack#add('rhysd/committia.vim')
jetpack#add('rhysd/git-messenger.vim', { on_cmd: 'GitMessenger', on_map: '<Plug>(git-messenger)' })
jetpack#add('Yggdroot/indentLine')
jetpack#add('Raimondi/delimitMate')
jetpack#add('91khr/rainbow')
g:rainbow_active = 1
jetpack#add('tpope/vim-sleuth')
jetpack#add('chrisbra/unicode.vim')
g:Unicode_data_directory = vim_data .. '/Unicode'
g:Unicode_cache_directory = vim_cache .. '/Unicode'
jetpack#add('tpope/vim-eunuch')
jetpack#add('tomtom/tcomment_vim')
jetpack#add('skywind3000/asyncrun.vim')
jetpack#add('SirVer/ultisnips')
jetpack#add('andymass/vim-matchup')
autocmd User JetpackPost:VimMatchup execute let g:loaded_matchit = 1
jetpack#add('tpope/vim-repeat')
jetpack#add('tpope/vim-endwise')
jetpack#add('markonm/traces.vim')
if !exists('$DBUS_SESSION_BUS_ADDRESS') | g:loaded_fcitx = 1 | endif
jetpack#add('lilydjwg/fcitx.vim')
jetpack#add('Shougo/echodoc.vim')
jetpack#add('Shougo/context_filetype.vim')
#jetpack#add('machakann/vim-sandwich')
jetpack#add('monkoose/vim9-stargate')
jetpack#add('AndrewRadev/splitjoin.vim')
#jetpack#add('dense-analysis/ale')
jetpack#add('ludovicchabant/vim-gutentags')
jetpack#add('skywind3000/gutentags_plus')
jetpack#add('skywind3000/vim-preview')
autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>
jetpack#add('preservim/tagbar')
jetpack#add('rrethy/vim-hexokinase', { build: 'make hexokinase', on_cmd: 'HexokinaseToggle' })
jetpack#add('dstein64/vim-startuptime', { on_cmd: 'StartupTime' })
jetpack#add('rhysd/vim-healthcheck', { on_cmd: 'CheckHealth' })
jetpack#add('mattkretz/vim-gnuindent', { on_cmd: 'SetupGnuIndent' })
jetpack#add('inkarkat/vim-mark', { on_cmd: 'Mark' })
jetpack#add('samoshkin/vim-mergetool', { on_cmd: ['MergetoolStart', 'MergetoolToggle'] })
jetpack#add('ntpeters/vim-better-whitespace')
g:better_whitespace_skip_empty_lines = 1
augroup rellinenum
    autocmd!
    autocmd InsertEnter * DisableWhitespace
    autocmd InsertLeave * EnableWhitespace
augroup END
jetpack#add('bootleq/vim-cycle')
jetpack#add('machakann/vim-highlightedyank')
g:highlightedyank_highlight_in_visual = 0
jetpack#add('thinca/vim-prettyprint')
# }}}

# Complete {{{
#jetpack#add('yegappan/lsp', { name: 'vim9lsp' })
jetpack#add('prabirshrestha/vim-lsp')
jetpack#add('mattn/vim-lsp-settings', { depends: ['prabirshrestha/vim-lsp'] })
jetpack#add('prabirshrestha/asyncomplete-lsp.vim', { depends: ['prabirshrestha/vim-lsp', 'prabirshrestha/asyncomplete.vim'] })
jetpack#add('thomasfaingnaert/vim-lsp-ultisnips', { depends: ['prabirshrestha/vim-lsp', 'SirVer/ultisnips'] })
jetpack#add('prabirshrestha/asyncomplete.vim')
jetpack#add('Shougo/neco-vim')
jetpack#add('prabirshrestha/asyncomplete-necovim.vim', { depends: ['prabirshrestha/asyncomplete.vim', 'Shougo/neco-vim'] })
jetpack#add('laixintao/asyncomplete-gitcommit')
jetpack#add('prabirshrestha/asyncomplete-file.vim')
jetpack#add('hiterm/asyncomplete-look')
jetpack#add('prabirshrestha/asyncomplete-buffer.vim')
#jetpack#add('machakann/asyncomplete-ezfilter.vim')
#jetpack#add('machakann/asyncomplete-unicodesymbol.vim')
# }}}

# Language {{{
jetpack#add('timonv/vim-cargo', { depends: ['cespare/vim-toml'] })
jetpack#add('egberts/vim-syntax-bind-named')
jetpack#add('bfrg/vim-cpp-modern', { on_ft: ['c', 'cpp'] })
jetpack#add('vim-crystal/vim-crystal', { on_ft: ['crystal'] })
jetpack#add('chrisbra/csv.vim', { on_ft: ['csv'] })
jetpack#add('hail2u/vim-css3-syntax', { on_ft: ['css'] })
jetpack#add('othree/html5.vim', { on_ft: ['html'] })
jetpack#add('peterhoeg/vim-qml')
jetpack#add('pboettch/vim-cmake-syntax', { on_ft: ['cmake'] })
jetpack#add('bfrg/vim-cmake-help', { on_ft: ['cmake'] })
jetpack#add('bfrg/vim-cmakecache-syntax', { on_ft: ['cmakecache'] })
jetpack#add('bfrg/vim-jq', { on_ft: ['jq'] })
jetpack#add('bfrg/vim-cuda-syntax', { on_ft: ['cuda'] })
jetpack#add('cespare/vim-toml', { branch: 'main', on_ft: ['toml'] })
jetpack#add('mattn/webapi-vim')
jetpack#add('rust-lang/rust.vim', { on_ft: ['rust'], depends: ['mattn/webapi-vim', 'cespare/vim-toml'] })
jetpack#add('lfiolhais/vim-chisel', { on_ft: ['chisel'] })
jetpack#add('Vimjas/vim-python-pep8-indent', { on_ft: ['python'] })
jetpack#add('fatih/vim-go', { on_ft: ['go'] })
jetpack#add('HerringtonDarkholme/yats.vim', { on_ft: ['javescript', 'typescript'] })
jetpack#add('pangloss/vim-javascript', { on_ft: ['javescript', 'typescript'] })
jetpack#add('jelera/vim-javascript-syntax', { on_ft: ['javescript', 'typescript'] })
jetpack#add('styled-components/vim-styled-components', { branch: 'main', on_ft: ['javescript', 'typescript'] })
jetpack#add('jparise/vim-graphql', { on_ft: ['javescript', 'typescript'] })
jetpack#add('godlygeek/tabular', { on_ft: ['markdown'] })
jetpack#add('plasticboy/vim-markdown', { on_ft: ['markdown'] })
jetpack#add('neovimhaskell/haskell-vim', { on_ft: ['haskell'] })
jetpack#add('lervag/vimtex', { on_ft: ['tex', 'latex'] })
jetpack#add('chr4/nginx.vim', { on_ft: ['nginx'] })
jetpack#add('Matt-Deacalion/vim-systemd-syntax', { on_ft: ['systemd', 'networkd'] })
jetpack#add('nathangrigg/vim-beancount', { on_ft: ['beancount'] })
jetpack#add('nfnty/vim-nftables', { on_ft: ['nftables'] })
jetpack#add('udalov/kotlin-vim', { on_ft: ['kotlin'] })
jetpack#add('tikhomirov/vim-glsl', { on_ft: ['glsl'] })
jetpack#add('rhysd/vim-syntax-codeowners', { on_ft: ['codeowners'] })
jetpack#add('rbtnn/vim-vimscript_indentexpr', { on_ft: ['vim'] })
jetpack#add('benknoble/vim-racket', { on_ft: ['racket', 'scribble', 'racket-info'] })
jetpack#add('habamax/vim-rst', { on_ft: ['rst'] })
jetpack#add('habamax/vim-asciidoctor', { on_ft: ['asciidoctor'] })
jetpack#add('pearofducks/ansible-vim', { on_ft: ['ansible', 'ansible_hosts'] })
jetpack#add('glench/vim-jinja2-syntax', { on_ft: ['jinja'] })
jetpack#add('blankname/vim-fish', { on_ft: ['fish'] })
jetpack#add('ionide/Ionide-vim', { on_ft: ['fsharp'] })
jetpack#add('edwinb/idris2-vim', { on_ft: ['idris2', 'lidris2'] })
jetpack#add('rhysd/vim-llvm')
jetpack#add('voldikss/vim-mma', { on_ft: ['mma'] })
jetpack#add('mracos/mermaid.vim', { on_ft: ['mermaid'] })
jetpack#add('aklt/plantuml-syntax', { on_ft: ['plantuml'] })
jetpack#add('Shirk/vim-gas', { on_ft: ['gas'] })
jetpack#add('AndrewRadev/id3.vim')
jetpack#add('vim-ruby/vim-ruby', { on_ft: ['ruby', 'eruby', 'rbs'] })
# }}}

jetpack#end()

