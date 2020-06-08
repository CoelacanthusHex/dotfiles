" system default
runtime! archlinux.vim


"""""""""""""""""""""""""""""""""""" 插件

if has("win32")
    let $PlugPath=$XDG_DATA_HOME."\\nvim-data\\dein"

    " 改变 swapfile 文件位置
    set directory=$XDG_DATA_HOME\\nvim-data\\swap
else
    let $PlugPath=$HOME."/.vim/dein"
    " 自动安装
    """" Dein-begin
    if &runtimepath !~# '/dein.vim'
        let s:dein_dir = expand('~/.vim/dein/repos/github.com/Shougo/dein.vim')

    if !isdirectory(s:dein_dir)
        call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_dir))
    endif
    execute 'set runtimepath^=' . s:dein_dir
endif

endif

if dein#load_state('$PlugPath')
    call dein#begin('$PlugPath')

    call dein#add('~/.vim/dein/repos/github.com/Shougo/dein.vim')
    call dein#add('wsdjeg/dein-ui.vim')

    call dein#add('tpope/vim-fugitive')

    """"""""""""""""""""""""""" 主题配色
    "call dein#add('morhetz/gruvbox')
    call dein#add('joshdick/onedark.vim')
    " 状态栏
    call dein#add('vim-airline/vim-airline')
    " 状态栏主题
    call dein#add('vim-airline/vim-airline-themes')

    call dein#add('lilydjwg/fcitx.vim')
    call dein#add('kassio/neoterm')
    " 支持库，给其他插件用的函数库
	call dein#add('xolox/vim-misc')
    " 缩进指示线
    call dein#add('Yggdroot/indentLine')
    " 自动括号
    call dein#add('jiangmiao/auto-pairs')
    " 注释插入
    call dein#add('preservim/nerdcommenter')
    " 彩虹括号
    call dein#add('luochen1990/rainbow')
    " HELP文档中文
    call dein#add('yianwillis/vimcdoc')
    call dein#add('Shougo/context_filetype.vim')

    " 代码格式化
    call dein#add('sbdchd/neoformat')
    map <F5> :Neoformat <CR>

    " 异步运行命令
    call dein#add('skywind3000/asyncrun.vim')
    " 自动打开高度为6的Quickfix
    let g:asyncrun_open=6
    " 项目编译配置 Wait To Use
    "call dein#add('skywind3000/asynctasks.vim')

    " 目录树
    call dein#add('preservim/nerdtree')
    map <C-n> :NERDTreeToggle<CR>
    let NERDTreeShowHidden=1
    "call dein#add('tiagofumo/vim-nerdtree-syntax-highlight')
    " enables folder icon highlighting using exact match
    "let g:NERDTreeHighlightFolders = 1
    " highlights the folder name
    "let g:NERDTreeHighlightFoldersFullName = 1
    " 图标
    call dein#add('ryanoasis/vim-devicons')
    call dein#add('liuchengxu/nerdtree-dash')

    """"""""""""""""""""""""""" 自动补全
    call dein#add('Shougo/deoplete.nvim')
    if !has('nvim')
        call dein#add('roxma/nvim-yarp')
        call dein#add('roxma/vim-hug-neovim-rpc')
    endif
    " 自动启动
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#profile = 1
    "call deoplete#custom#option('profile', v:true)
	"call deoplete#enable_logging('DEBUG', 'deoplete.log')
	"call deoplete#custom#source('jedi', 'is_debug_enabled', 1)
    call deoplete#enable()
    " Integration with TabNine - a machine learning-based all-language autocompleter
    if has('win32') || has('win64')
        call dein#add('tbodt/deoplete-tabnine', { 'build': 'powershell.exe .\install.ps1' })
    else
        call dein#add('tbodt/deoplete-tabnine', { 'build': './install.sh' })
    endif
    " Syntax source for neocomplete/deoplete/ncm
    call dein#add('shougo/neco-syntax')
    " Include completion framework for neocomplete/deoplete
    call dein#add('Shougo/neoinclude.vim')

    " Language Server
    call dein#add('autozimu/LanguageClient-neovim', {
    \ 'rev': 'next',
    \ 'build': 'bash install.sh',
    \ })

    let g:LanguageClient_autoStart = 1
    let g:LanguageClient_autoStop = 1
    " the suddennly popup of diagnostics sign is kind of annoying
    let g:LanguageClient_diagnosticsSignsMax = 0
    let g:LanguageClient_loadSettings = 1 " Use an absolute configuration path if you want system-wide settings
    let g:LanguageClient_settingsPath = '~/.config/nvim/settings.json'
    let g:LanguageClient_serverCommands = {
        \ 'c': ['/usr/bin/ccls', '--log-file=/tmp/cc.log'],
        \ 'cpp': ['/usr/bin/ccls', '--log-file=/tmp/cc.log'],
        \ 'cuda': ['/usr/bin/ccls', '--log-file=/tmp/cc.log'],
        \ 'objc': ['/usr/bin/ccls', '--log-file=/tmp/cc.log'],
        \ 'rust': ['rls'],
        \ 'typescript': ['/usr/bin/javascript-typescript-stdio'],
        \ 'javascript': ['/usr/bin/javascript-typescript-stdio'],
        \ 'haskell': ['hie-wrapper', '--lsp']
        \ }

    " ccls Config
    let s:ccls_settings = {
         \ 'highlight': { 'lsRanges' : v:true },
         \ }

    """"""""""""""""""""""""""" Language


    " languages highlight packs
    call dein#add('sheerun/vim-polyglot')


    """"""" C
    " C++ 的clang补全
    " 见下


    """"""" Python
    " Python 补全源
    call dein#add('deoplete-plugins/deoplete-jedi',{'on_ft':'python'})
    "call dein#add('deoplete-plugins/deoplete-jedi')


    """"""" Rust
    " Rust 支持
    call dein#add('rust-lang/rust.vim',{'on_ft':'rust'})
    " 保存时自动格式化
    let g:autofmt_autosave = 1
    " Cargo 增强
    call dein#add('timonv/vim-cargo')
    
    """"""" Haskell
    "call dein#add('eagletmt/neco-ghc')
    call dein#add('nbouscal/vim-stylish-haskell')


    """"""" Markdown
    " markdown syntax highlight, theme
    call dein#add('plasticboy/vim-markdown',{'on_ft':'markdown'})
    " Markdown 语法支持
    call dein#add('SidOfc/mkdx')
    let g:mkdx#settings     = { 'highlight': { 'enable': 1 },
                        \ 'enter': { 'shift': 1 },
                        \ 'links': { 'external': { 'enable': 1 } },
                        \ 'toc': { 'text': 'Table of Contents', 'update_on_write': 1 },
                        \ 'fold': { 'enable': 0 } }
    " for vim-polyglot users, it loads Plasticboy's markdown
    " plugin which unfortunately interferes with mkdx list indentation.
    let g:polyglot_disabled = ['markdown']
    " 笔记
    call dein#add('vimwiki/vimwiki')
    let g:vimwiki_list = [{
            \ 'path': '~/Documents/Notes/', 'index': 'index', 'ext': '.mw',
            \ 'auto_tags': 1,
            \ 'nested_syntaxes': {'py': 'python', 'cpp': 'cpp', 'c':'c', 'rust':'rust'}
            \ }]


    """"""" Vim Script
    call dein#add('Shougo/neco-vim',{'on_ft':'vim'})
    
    
    """"""" Haskell
    call dein#add('neovimhaskell/haskell-vim',{'on_ft':'haskell'})
    let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
    let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
    let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
    let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
    let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
    let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
    let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

    """"""" Pandoc
    " Pandoc Support
    call dein#add('vim-pandoc/vim-pandoc')
    " Pandoc Syntax Highlight Support
    call dein#add('vim-pandoc/vim-pandoc-syntax')


    """"""" LaTeX
    call dein#add('lervag/vimtex')
    call deoplete#custom#var('omni', 'input_patterns', {
        \ 'tex': g:vimtex#re#deoplete
        \})


    """"""" Nginx
    call dein#add('chr4/nginx.vim')
    call dein#add('Shougo/echodoc.vim')


    """"""" systemd 文件的语法高亮
    call dein#add('Matt-Deacalion/vim-systemd-syntax')


    """"""" HTML bundles
    " Tag matches for HTML
    call dein#add('gregsexton/MatchTag',{'on_ft':'html'})
    call dein#add('heracek/HTML-AutoCloseTag',{'on_ft':'html'})
    call dein#add('hail2u/vim-css3-syntax',{'on_ft':'html'})



    call dein#end()
    call dein#save_state()

    " Asynchronous C/C++/Objective-C/Objective-C++ completion for Neovim.
    " Change clang binary path
    call deoplete#custom#var('clangx', 'clang_binary', '/usr/bin/clang')
    " Change clang options
    call deoplete#custom#var('clangx', 'default_c_options', '-Wall')
    call deoplete#custom#var('clangx', 'default_cpp_options', '-Wall')

endif

call deoplete#toggle()

" Workaround: dein#begin() will execute filetype off
if has('autocmd')
	filetype plugin indent on
endif

if has('syntax')
	syntax enable
	syntax on
endif

set mouse=a
set number
set modeline

" 高亮显示当前行/列
set cursorline
set cursorcolumn
" 总是显示侧边栏（用于显示 mark/gitdiff/诊断信息）
set signcolumn=yes

" 在状态栏显示正在输入的命令
set showcmd

" 终端使用真彩色(guicolor)
set termguicolors

" 左下角显示当前vim模式
" set showmode

" 自动缩进
set autoindent
set smartindent

" ctrl+hjkl 移动窗口
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ [%{(&fenc==\"\"?&enc:&fenc).(&bomb?\",BOM\":\"\")}]\ %c:%l/%L%)

set backspace=indent,eol,start
set tabstop=4
set shiftwidth=4

set langmenu=zh_CN.UTF-8
set helplang=cn
set termencoding=utf-8
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,gbk,cp936,gb2312,gb18030
set fileformats=unix,dos,mac

" 如遇Unicode值大于255的文本，不必等到空格再折行
set formatoptions+=m

" 合并两行中文时，不在中间加空格
set formatoptions+=B

" Enable a visual menu when using TAB autocomplete in command mode
set wildmenu

" 延迟绘制（提升性能）
set lazyredraw

" 显示tab和空格
set list
" 设置tab和空格样式
set lcs=tab:\|\ ,nbsp:%,trail:-

"----------------------------------------------------------------------
" 搜索设置
"----------------------------------------------------------------------

" 搜索时忽略大小写
set ignorecase

" 智能搜索大小写判断，默认忽略大小写，除非搜索内容包含大写字母
set smartcase

" 高亮搜索内容
set hlsearch

" 查找输入时动态增量显示查找结果
set incsearch

" delete trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


""""""""""""""""""""""""""""""""""""" gruvbox
let g:gruvbox_bold=1
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_improved_strings=1


""""""""""""""""""""""""""""""""""""" NERDTree
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" 最后是个 window 是 NERDTree 时自动退出
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


""""""""""""""""""""""""""""""""""""" 配色方案
set background=dark
"colorscheme gruvbox
colorscheme onedark


""""""""""""""""""""""""""""""""""""" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
"let g:airline_theme='light'
"显示 buffer 编号
let g:airline#extensions#tabline#buffer_nr_show = 1

let g:airline_theme='onedark'


"""""""""""""""""""""""""""""""""""""" Function

let mapleader="\\"

"  删除所有未显示且无修改的缓冲区以减少内存占用
function Lilydjwg_cleanbufs()
  for bufNr in filter(range(1, bufnr('$')),
        \ 'buflisted(v:val) && !bufloaded(v:val)')
    execute bufNr . 'bdelete'
  endfor
endfunction

map <F2> :call Biaodian() <CR>
function Biaodian()
    %s/”/"/g
    %s/“/"/g
    %s/，/,/g
    %s/。/./g
    %s/？/?/g
    %s/〈/</g
    %s/〉/>/g
    %s/（/(/g
    %s/）/)/g
    %s/：/:/g
    %s/；/;/g
    %s/‘/'/g
    %s/’/'/g
    %s/！/!/g
endfunction

nnoremap <leader>ff :Neoformat<CR>

" F9编译
nnoremap <F9> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    exec '!g++ % -o %< -Wall -Wextra -march=native -pipe -fsanitize=address -fsanitize=undefined'
    exec '!time ./%<'
    endfunc

" F12清屏
nnoremap <F12> :call Clss()<CR>
func! Clss()
    exec '!clear'
    endfunc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""新文件标题
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,.java文件，自动插入文件头
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py exec ":call SetTitle()"
""定义函数SetTitle，自动插入文件头
func SetTitle()
    "如果文件类型为.sh文件
    if &filetype == 'sh'
        call setline(1,"\#!/bin/bash")
        call append(line("."), "")
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# coding=utf-8")
        call append(line(".")+1, "")

    elseif &filetype == 'ruby'
        call setline(1,"#!/usr/bin/env ruby")
        call append(line("."),"# encoding: utf-8")
        call append(line(".")+1, "")

"    elseif &filetype == 'mkd'
"        call setline(1,"<head><meta charset=\"UTF-8\"></head>")
    else
        call setline(1, "/*************************************************************************")
        call append(line("."), "	> File Name: ".expand("%"))
        call append(line(".")+1, "	> Author: ")
        call append(line(".")+2, "	> Mail: ")
        call append(line(".")+3, "	> Created Time: ".strftime("%c"))
        call append(line(".")+4, " ************************************************************************/")
        call append(line(".")+5, "")
    endif
    if expand("%:e") == 'cpp'
        call append(line(".")+6, "#include <iostream>")
        call append(line(".")+7, "int main(){")
                call append(line(".")+8, "     ")
                call append(line(".")+9, "     return 0;")
                call append(line(".")+10, "}")
    endif
    if &filetype == 'c'
        call append(line(".")+6, "#include <stdio.h>")
                call append(line(".")+7, "int main(){")
                call append(line(".")+8, "     ")
                call append(line(".")+9, "     return 0;")
                call append(line(".")+10, "}")
    endif
    if expand("%:e") == 'h'
        call append(line(".")+6, "#ifndef _".toupper(expand("%:r"))."_H")
        call append(line(".")+7, "#define _".toupper(expand("%:r"))."_H")
        call append(line(".")+8, "#endif")
    endif
    if &filetype == 'java'
        call append(line(".")+6,"public class ".expand("%:r"))
        call append(line(".")+7,"")
    endif
    "新建文件后，自动定位到文件末尾
endfunc
autocmd BufNewFile * normal G
