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

# Tools {{{
jetpack#add('vim-airline/vim-airline')
jetpack#add('vim-airline/vim-airline-themes')
jetpack#add('tpope/vim-fugitive')
jetpack#add('airblade/vim-gitgutter')
jetpack#add('rhysd/committia.vim')
jetpack#add('rhysd/git-messenger.vim', { cmd: 'GitMessenger', on_map: '<Plug>(git-messenger)' })
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
autocmd User JetpackVimMatchupPost execute let g:loaded_matchit = 1
jetpack#add('tpope/vim-repeat')
jetpack#add('tpope/vim-endwise')
jetpack#add('markonm/traces.vim')
jetpack#add('lilydjwg/fcitx.vim')
jetpack#add('Shougo/echodoc.vim')
jetpack#add('Shougo/context_filetype.vim')
#jetpack#add('machakann/vim-sandwich')
jetpack#add('monkoose/vim9-stargate')
jetpack#add('AndrewRadev/splitjoin.vim')
#jetpack#add('dense-analysis/ale')
jetpack#add('vim-scripts/gtags.vim')
#jetpack#add('ludovicchabant/vim-gutentags')
jetpack#add('preservim/tagbar')
jetpack#add('rrethy/vim-hexokinase', { do: 'make hexokinase', cmd: 'HexokinaseToggle' })
jetpack#add('dstein64/vim-startuptime', { cmd: 'StartupTime' })
jetpack#add('rhysd/vim-healthcheck', { cmd: 'CheckHealth' })
jetpack#add('mattkretz/vim-gnuindent', { cmd: 'SetupGnuIndent' })
jetpack#add('inkarkat/vim-mark', { cmd: 'Mark' })
jetpack#add('samoshkin/vim-mergetool', { cmd: ['MergetoolStart', 'MergetoolToggle'] })
g:mergetool_layout = 'MR'
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
# }}}

# Complete {{{
jetpack#add('yegappan/lsp', { opt: 1, as: 'vim9lsp' })
jetpack#add('prabirshrestha/vim-lsp')
jetpack#add('mattn/vim-lsp-settings')
jetpack#add('prabirshrestha/asyncomplete-lsp.vim')
jetpack#add('thomasfaingnaert/vim-lsp-ultisnips')
jetpack#add('prabirshrestha/asyncomplete.vim')
jetpack#add('Shougo/neco-vim')
jetpack#add('prabirshrestha/asyncomplete-necovim.vim')
jetpack#add('laixintao/asyncomplete-gitcommit')
jetpack#add('prabirshrestha/asyncomplete-file.vim')
jetpack#add('hiterm/asyncomplete-look')
jetpack#add('prabirshrestha/asyncomplete-buffer.vim')
#jetpack#add('machakann/asyncomplete-ezfilter.vim')
#jetpack#add('machakann/asyncomplete-unicodesymbol.vim')
# }}}

# Language {{{
jetpack#add('timonv/vim-cargo')
jetpack#add('egberts/vim-syntax-bind-named')
jetpack#add('bfrg/vim-cpp-modern', { ft: ['c', 'cpp'] })
jetpack#add('vim-crystal/vim-crystal')
jetpack#add('chrisbra/csv.vim', { ft: ['csv'] })
jetpack#add('vim-crystal/vim-crystal', { ft: ['crystal'] })
jetpack#add('hail2u/vim-css3-syntax', { ft: ['css'] })
jetpack#add('othree/html5.vim', { ft: ['html'] })
jetpack#add('peterhoeg/vim-qml', { ft: ['qml'] })
jetpack#add('pboettch/vim-cmake-syntax', { ft: ['cmake'] })
jetpack#add('bfrg/vim-cmake-help', { ft: ['cmake'] })
jetpack#add('bfrg/vim-cmakecache-syntax', { ft: ['cmakecache'] })
jetpack#add('bfrg/vim-jq', { ft: ['jq'] })
jetpack#add('bfrg/vim-cuda-syntax', { ft: ['cuda'] })
jetpack#add('cespare/vim-toml', { branch: 'main', ft: ['toml'] })
jetpack#add('mattn/webapi-vim', { event: 'User JetpackRustVimPre' })
jetpack#add('rust-lang/rust.vim', { ft: ['rust'] })
jetpack#add('lfiolhais/vim-chisel', { ft: ['chisel'] })
jetpack#add('Vimjas/vim-python-pep8-indent', { ft: ['python'] })
jetpack#add('fatih/vim-go', { ft: ['go'] })
jetpack#add('HerringtonDarkholme/yats.vim', { ft: ['javescript', 'typescript'] })
jetpack#add('pangloss/vim-javascript', { ft: ['javescript', 'typescript'] })
jetpack#add('jelera/vim-javascript-syntax', { ft: ['javescript', 'typescript'] })
jetpack#add('styled-components/vim-styled-components', { branch: 'main', ft: ['javescript', 'typescript'] })
jetpack#add('jparise/vim-graphql', { ft: ['javescript', 'typescript'] })
jetpack#add('godlygeek/tabular', { ft: ['markdown'] })
jetpack#add('plasticboy/vim-markdown', { ft: ['markdown'] })
jetpack#add('neovimhaskell/haskell-vim', { ft: ['haskell'] })
jetpack#add('lervag/vimtex', { ft: ['tex', 'latex'] })
jetpack#add('chr4/nginx.vim', { ft: ['nginx'] })
jetpack#add('Matt-Deacalion/vim-systemd-syntax', { ft: ['systemd', 'networkd'] })
jetpack#add('nathangrigg/vim-beancount', { ft: ['beancount'] })
jetpack#add('nfnty/vim-nftables', { ft: ['nftables'] })
jetpack#add('udalov/kotlin-vim', { ft: ['kotlin'] })
jetpack#add('tikhomirov/vim-glsl', { ft: ['glsl'] })
jetpack#add('rhysd/vim-syntax-codeowners', { ft: ['codeowners'] })
jetpack#add('rbtnn/vim-vimscript_indentexpr', { ft: ['vim'] })
jetpack#add('benknoble/vim-racket', { ft: ['racket', 'scribble', 'racket-info'] })
jetpack#add('habamax/vim-rst', { ft: ['rst'] })
jetpack#add('habamax/vim-asciidoctor', { ft: ['asciidoctor'] })
jetpack#add('pearofducks/ansible-vim', { ft: ['ansible', 'ansible_hosts'] })
jetpack#add('glench/vim-jinja2-syntax', { ft: ['jinja'] })
jetpack#add('blankname/vim-fish', { ft: ['fish'] })
jetpack#add('ionide/Ionide-vim', { ft: ['fsharp'] })
jetpack#add('edwinb/idris2-vim', { ft: ['idris2', 'lidris2'] })
jetpack#add('rhysd/vim-llvm')
jetpack#add('voldikss/vim-mma', { ft: ['mma'] })
jetpack#add('mracos/mermaid.vim', { ft: ['mermaid'] })
jetpack#add('aklt/plantuml-syntax', { ft: ['plantuml'] })
jetpack#add('Shirk/vim-gas', { ft: ['gas'] })
# }}}

jetpack#end()

