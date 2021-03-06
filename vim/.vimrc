" system default
runtime! archlinux.vim


"""""""""""""""""""""""""""""""""""" 插件

if has("win32")
    let $PlugPath=$XDG_DATA_HOME."\\vim-data\\dein"

    " 改变 swapfile 文件位置
    set directory=$XDG_DATA_HOME\\vim-data\\swap
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

let g:dein#auto_recache = 1

let g:polyglot_disabled = ['markdown']

if dein#load_state('$PlugPath')
    call dein#begin('$PlugPath')

    call dein#add('~/.vim/dein/repos/github.com/Shougo/dein.vim')
    call dein#add('wsdjeg/dein-ui.vim')


    """"""""""""""""""""""""" 主题配色
    call dein#add('joshdick/onedark.vim')
    " 状态栏
    call dein#add('vim-airline/vim-airline')
    " 状态栏主题
    call dein#add('vim-airline/vim-airline-themes')

    " 代码格式化
    call dein#add('sbdchd/neoformat')
    map <F5> :Neoformat <CR>

    " Fcitx
    call dein#add('lilydjwg/fcitx.vim')

    " 缩进指示线
    call dein#add('Yggdroot/indentLine')
    " 自动括号
    call dein#add('jiangmiao/auto-pairs')
    " Tagbar
    call dein#add('majutsushi/tagbar')
    " 彩虹括号
    call dein#add('luochen1990/rainbow')
    " HELP文档中文
    call dein#add('yianwillis/vimcdoc')

    " 异步运行命令
    call dein#add('skywind3000/asyncrun.vim')
    " 自动打开高度为6的Quickfix
    let g:asyncrun_open=6
    " 项目编译配置 Wait To Use
    "call dein#add('skywind3000/asynctasks.vim')

    ""
    call dein#add('Shougo/context_filetype.vim')

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

    call dein#add('dense-analysis/ale',{'on_ft': ['sh', 'c', 'cpp', 'rust', 'python', 'go', 'tex']})

    """"""""""""""""""""""""""" 自动补全
    " 现在使用 YouCompleteMe


    """"""""""""""""""""""""""" Language


    " languages highlight packs
	let g:polyglot_disabled = ['markdown']
	call dein#add('sheerun/vim-polyglot')


    """"""" C & C++
    call dein#add('vim-scripts/gtags.vim',{'on_ft': ['c', 'cpp']})
    " C++ 的clang补全
    " 见下


    """"""" Python
    " Python 补全源
    "call dein#add('deoplete-plugins/deoplete-jedi',{'on_ft':'python'})
    "call dein#add('deoplete-plugins/deoplete-jedi')


    """"""" Rust
    " Rust 支持
    call dein#add('rust-lang/rust.vim',{'on_ft': 'rust'})
    call dein#add('racer-rust/vim-racer',{'on_ft': 'rust'})
    " 保存时自动格式化
    let g:autofmt_autosave = 1
    " Cargo 增强
    call dein#add('timonv/vim-cargo')


    """"""" Go
    call dein#add('fatih/vim-go',{'on_ft': 'go'})


    """"""" Markdown
    " markdown syntax highlight, theme
    call dein#add('plasticboy/vim-markdown',{'on_ft':'markdown'})
    " Markdown 语法支持
    call dein#add('SidOfc/mkdx')


    """"""" Vim Script
    call dein#add('Shougo/neco-vim',{'on_ft':'vim'})


    """"""" Haskell
    call dein#add('neovimhaskell/haskell-vim',{'on_ft':'haskell'})


    """"""" Pandoc
    " Pandoc Support
    call dein#add('vim-pandoc/vim-pandoc')
    " Pandoc Syntax Highlight Support
    call dein#add('vim-pandoc/vim-pandoc-syntax')


    """"""" LaTeX
    call dein#add('lervag/vimtex')


    """"""" Nginx
    call dein#add('chr4/nginx.vim')
    call dein#add('Shougo/echodoc.vim')


    """"""" systemd 文件的语法高亮
    call dein#add('Matt-Deacalion/vim-systemd-syntax')


    """"""" PKGBUILD
    call dein#add('Firef0x/PKGBUILD.vim')

    call dein#add('nathangrigg/vim-beancount')

    call dein#end()
    call dein#save_state()

endif

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

""""""""""""""""""""""""""""""""""""" Extensions Setting

" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-
set tags=tags;/

""""""" 配色方案
set background=dark
"colorscheme gruvbox
colorscheme onedark

""""""" taglist Configuration
let Tlist_Sort_Type = "name"                                   " 按照名称排序
let Tlist_Use_Right_Window = 1                                 " 在右侧显示窗口
let Tlist_Compart_Format = 1                                   " 压缩方式
let Tlist_Exist_OnlyWindow = 1                                 " 如果只有一个buffer，kill窗口也kill掉buffer
let Tlist_File_Fold_Auto_Close = 0                             " 不要关闭其他文件的tags
let Tlist_Enable_Fold_Column = 0                               " 不要显示折叠树

" Load user config files only if the file exist, supress warning
function! LoadCustomConfig(config)
    if filereadable(expand(a:config))
        exec 'source' a:config
    endif
endfunction
command! -nargs=1 LoadConfig call LoadCustomConfig(<f-args>)

" LoadConfig ~/.config/vim/conf.d/
LoadConfig ~/.config/vim/conf.d/airline.vim
LoadConfig ~/.config/vim/conf.d/ale.vim
LoadConfig ~/.config/vim/conf.d/autopair.vim
LoadConfig ~/.config/vim/conf.d/gruvbox.vim
LoadConfig ~/.config/vim/conf.d/gtags.vim
LoadConfig ~/.config/vim/conf.d/haskell-vim.vim
LoadConfig ~/.config/vim/conf.d/language-server.vim
LoadConfig ~/.config/vim/conf.d/mkdx.vim
LoadConfig ~/.config/vim/conf.d/nerdtree.vim
LoadConfig ~/.config/vim/conf.d/racer.vim
LoadConfig ~/.config/vim/conf.d/vim-go.vim
LoadConfig ~/.config/vim/conf.d/vimtex.vim
LoadConfig ~/.config/vim/conf.d/beancount.vim

"""""""""""""""""""""""""""""""""""""" Function

let mapleader="\\"

" 删除所有未显示且无修改的缓冲区以减少内存占用
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

" F12清屏
nnoremap <F12> :call Clss()<CR>
func! Clss()
    exec '!clear'
    endfunc

""""""""""""""""""""""""""""""""""""" 新文件标题

" 新建.c,.h,.sh,.java文件，自动插入文件头
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py exec ":call SetTitle()"
"" 定义函数SetTitle，自动插入文件头
func SetTitle()
    " 如果文件类型为.sh文件
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
        call append(line(".")+7, "int main() {")
                call append(line(".")+8, "    ")
                call append(line(".")+9, "    return 0;")
                call append(line(".")+10, "}")
    endif
    if &filetype == 'c'
        call append(line(".")+6, "#include <stdio.h>")
                call append(line(".")+7, "int main() {")
                call append(line(".")+8, "    ")
                call append(line(".")+9, "    return 0;")
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
    " 新建文件后，自动定位到文件末尾
endfunc
autocmd BufNewFile * normal G
