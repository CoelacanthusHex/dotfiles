vim9script
# vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
# kate: space-indent on; indent-width 4; syntax vim;

# SPDX-License-Identifier: MPL-2.0
# SPDX-FileCopyrightText: Coelacanthus

packadd jetpack

$CACHE = expand('~/.cache')
if !isdirectory($CACHE)
    mkdir($CACHE, 'p')
endif

jetpack#begin()
jetpack#add('vim-airline/vim-airline')
jetpack#add('vim-airline/vim-airline-themes')
jetpack#add('tpope/vim-fugitive')
jetpack#add('airblade/vim-gitgutter')
jetpack#add('Yggdroot/indentLine')
jetpack#add('Raimondi/delimitMate')
jetpack#add('91khr/rainbow')
autocmd User JetpackRainbowPost execute let g:rainbow_active = 1
jetpack#add('tpope/vim-sleuth')
jetpack#add('chrisbra/unicode.vim')
jetpack#add('tpope/vim-eunuch')
jetpack#add('tomtom/tcomment_vim')
jetpack#add('skywind3000/asyncrun.vim')
jetpack#add('SirVer/ultisnips')
g:UltiSnipsSnippetDirectories = [$HOME .. '/.vim/UltiSnips']
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

def UltiSnipsSetMap()
    autocmd InsertEnter * execute "inoremap <silent> " . g:UltiSnipsExpandTrigger     . " <C-R>=g:UltiSnips_Complete()<cr>"
    autocmd InsertEnter * execute "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"
enddef
autocmd User JetpackRainbowPost call UltiSnipsSetMap()
jetpack#add('andymass/vim-matchup')
autocmd User JetpackVimMatchupPost execute let g:loaded_matchit = 1
jetpack#add('tpope/vim-repeat')
jetpack#add('tpope/vim-endwise')
jetpack#add('markonm/traces.vim')
jetpack#add('lilydjwg/fcitx.vim')
jetpack#add('Shougo/echodoc.vim')
jetpack#add('Shougo/context_filetype.vim')
jetpack#add('timonv/vim-cargo')
jetpack#add('machakann/vim-sandwich')
jetpack#add('egberts/vim-syntax-bind-named')
jetpack#add('AndrewRadev/splitjoin.vim')
jetpack#add('octol/vim-cpp-enhanced-highlight', { ft: ['c', 'cpp'] })
jetpack#add('chrisbra/csv.vim', { ft: ['csv'] })
jetpack#add('vim-crystal/vim-crystal', { ft: ['crystal'] })
jetpack#add('hail2u/vim-css3-syntax', { ft: ['css'] })
jetpack#add('othree/html5.vim', { ft: ['html'] })
jetpack#add('peterhoeg/vim-qml', { ft: ['qml'] })
jetpack#add('pboettch/vim-cmake-syntax', { ft: ['cmake'] })
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
jetpack#add('yegappan/lsp', { opt: 1, as: 'vim9lsp' })
jetpack#add('prabirshrestha/vim-lsp', { opt: 1 })
jetpack#add('mattn/vim-lsp-settings', { event: 'User JetpackVimLspPost' })
jetpack#add('dense-analysis/ale')
jetpack#add('vim-scripts/gtags.vim')
jetpack#add('ludovicchabant/vim-gutentags')
jetpack#add('rrethy/vim-hexokinase', { do: 'make hexokinase', opt: 1 })
jetpack#add('roxma/nvim-yarp', { opt: 1 })
jetpack#add('roxma/vim-hug-neovim-rpc', { opt: 1 })
jetpack#add('dstein64/vim-startuptime', { cmd: 'StartupTime' })
jetpack#add('rhysd/vim-healthcheck', { cmd: 'CheckHealth' })
jetpack#add('mattkretz/vim-gnuindent', { cmd: 'SetupGnuIndent' })
jetpack#add('inkarkat/vim-mark', { cmd: 'Mark' })

jetpack#end()

