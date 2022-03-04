vim9script
# vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
# kate: space-indent on; indent-width 4; syntax vim;

# SPDX-License-Identifier: MPL-2.0
# SPDX-FileCopyrightText: Coelacanthus

# 自动安装 {{{
var data_dir = has('nvim') ? stdpath('data') .. '/site' : '~/.vim'
if empty(glob(data_dir .. '/autoload/plug.vim'))
    silent execute '!curl -fLo ' .. data_dir .. '/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
# }}}

call plug#begin('~/.vim/plugged')

    Plug 'junegunn/vim-plug'

    # 主题配色 {{{
    Plug 'joshdick/onedark.vim'
    # 状态栏
    Plug 'vim-airline/vim-airline'
    # 状态栏主题
    Plug 'vim-airline/vim-airline-themes'
    # }}}
    
    # Misc {{{
    # 代码格式化
    Plug 'sbdchd/neoformat'
    map <F5> :Neoformat <CR>
    # Git
    Plug 'tpope/vim-git'
    Plug 'tpope/vim-fugitive'
    # Git sign column
    Plug 'airblade/vim-gitgutter'
    # Fcitx
    if exists("$DISPLAY") || exists("$WAYLAND_DISPLAY")
        Plug 'lilydjwg/fcitx.vim'
    endif
    # 缩进指示线
    Plug 'Yggdroot/indentLine'
    # 自动括号
    Plug 'Raimondi/delimitMate'
    # Tagbar
    Plug 'majutsushi/tagbar'
    # 彩虹括号
    Plug '91khr/rainbow'
    g:rainbow_active = 1
    # EditorConfig
    #Plug 'editorconfig/editorconfig-vim'
    # 颜色代码转颜色
    #Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
    # Auto detect indent size
    #Plug 'tpope/vim-sleuth'
    # Unicode
    Plug 'chrisbra/unicode.vim'
    # Sudo support
    Plug 'lambdalisue/suda.vim'
    # Snippets
    Plug 'SirVer/ultisnips'
    g:UltiSnipsSnippetDirectories = [$HOME .. '/.vim/UltiSnips']
    Plug 'tomtom/tcomment_vim'
    Plug 'skywind3000/asyncrun.vim'
    Plug 'andymass/vim-matchup'
    g:loaded_matchit = 1

    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-endwise'
    Plug 'Shougo/echodoc.vim'
    Plug 'Shougo/context_filetype.vim'

    Plug 'dense-analysis/ale', {'for': ['sh', 'c', 'cpp', 'rust', 'python', 'go', 'tex']}

    Plug 'vim-scripts/gtags.vim'
    Plug 'ludovicchabant/vim-gutentags'
    
    # For test
    Plug 'dstein64/vim-startuptime'
    # }}}

    # 自动补全 {{{
    # 现在使用 YouCompleteMe
    if has("win32") || has("win64") || !filereadable('/usr/share/vim/vimfiles/plugin/youcompleteme.vim')
        Plug 'prabirshrestha/vim-lsp'
        Plug 'mattn/vim-lsp-settings'
        Plug 'prabirshrestha/asyncomplete.vim'
        Plug 'prabirshrestha/asyncomplete-lsp.vim'
        Plug 'prabirshrestha/asyncomplete-file.vim'
        Plug 'prabirshrestha/asyncomplete-buffer.vim'
        Plug 'hiterm/asyncomplete-look'
        Plug 'Shougo/neco-vim'
        Plug 'prabirshrestha/asyncomplete-necovim.vim'
        if executable('ctags')
            Plug 'prabirshrestha/asyncomplete-tags.vim'
            Plug 'ludovicchabant/vim-gutentags'
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
    endif
    # TODO: using vim9lsp
    #Plug 'yegappan/lsp'
    # }}}

    # Language {{{
    

    ######## C++
    Plug 'octol/vim-cpp-enhanced-highlight', {'for': ['c', 'cpp']}


    ######## CSS && HTML
    Plug 'hail2u/vim-css3-syntax'
    Plug 'othree/html5.vim'
    
    
    ######## Qt
    Plug 'peterhoeg/vim-qml'
    Plug 'pboettch/vim-cmake-syntax'


    ######## Rust
    Plug 'cespare/vim-toml', { 'branch': 'main' }
    # Playpen integration
    Plug 'mattn/webapi-vim'
    # Rust 支持
    Plug 'rust-lang/rust.vim', {'for': 'rust'}
    # 保存时自动格式化
    #g:autofmt_autosave = 1
    # Cargo 增强
    Plug 'timonv/vim-cargo'


    ######## Scala
    Plug 'derekwyatt/vim-scala', {'for': 'scala'}
    Plug 'lfiolhais/vim-chisel'

    ######## Python
    Plug 'Vimjas/vim-python-pep8-indent', {'for': 'python'}


    ######## Go
    Plug 'fatih/vim-go', {'for': 'go'}
    
    
    ######## TypeScript
    Plug 'HerringtonDarkholme/yats.vim', {'for': ['javescript', 'typescript']}
    # https://thoughtbot.com/blog/modern-typescript-and-react-development-in-vim
    Plug 'pangloss/vim-javascript', {'for': ['javescript', 'typescript']}
    Plug 'jelera/vim-javascript-syntax', {'for': ['javescript', 'typescript']}
    Plug 'styled-components/vim-styled-components', { 'branch': 'main', 'for': ['javescript', 'typescript'] }
    Plug 'jparise/vim-graphql', {'for': ['javescript', 'typescript']}


    ######## Markdown
    # Markdown 语法支持
    Plug 'godlygeek/tabular', {'for': 'markdown'}
    Plug 'plasticboy/vim-markdown', {'for': 'markdown'}


    ######## Vim Script
    Plug 'Shougo/neco-vim', {'for':'vim'}


    ######## Haskell
    Plug 'neovimhaskell/haskell-vim', {'for': 'haskell'}


    ######## LaTeX
    Plug 'lervag/vimtex', {'for': ['tex', 'latex']}


    ######## Nginx
    Plug 'chr4/nginx.vim'


    ######## systemd 文件的语法高亮
    Plug 'Matt-Deacalion/vim-systemd-syntax'


    ######## Beancount
    Plug 'nathangrigg/vim-beancount'


    ######## Nftables
    Plug 'nfnty/vim-nftables'


    ######## Kitty
    Plug 'fladson/vim-kitty'


    ######## Others
    Plug 'rhysd/vim-syntax-codeowners'
    #}}}

call plug#end()


# https://github.com/ycm-core/YouCompleteMe/issues/36#issuecomment-171966710
def g:UltiSnips_Complete(): string
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
                return "\<TAB>"
            endif
        endif
    endif
    return ""
enddef

def g:UltiSnips_Reverse(): string
    call UltiSnips#JumpBackwards()
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
