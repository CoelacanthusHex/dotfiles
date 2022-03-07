" vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
" kate: space-indent on; indent-width 4; syntax vim;

" SPDX-License-Identifier: MPL-2.0
" SPDX-FileCopyrightText: Coelacanthus

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" Avoid side effects when it was already reset.
if &compatible
    set nocompatible
endif

" Set Path {{{
if has("win32") || has("win64")
    let g:vimfiles = split(&runtimepath, ',')[1]
    if has('directx')
        set renderoptions=type:directx
    endif
else
    " Linux 路径 [[[3
    let g:vimfiles = split(&runtimepath, ',')[0]
    " cron 的目录不要备份
    set backupskip+=/etc/cron.*/*
    set backupdir=.,/var/tmp,/tmp
endif
if exists(':packadd')
    " insert after the first one so spell changes won't go
    " into our config directory.
    let rtp = split(&runtimepath, ',')
    call insert(rtp, g:vimfiles . '/conf.d', 1)
    let &runtimepath = join(rtp, ',')
    unlet rtp
endif
" }}}

" 插件 {{{

" NOTE: Remove for only support Vim9

" }}}

" Platform specific config {{{

if has('win32')
  if !executable('pwsh')
    echoerr '[vim] PowerShell Core >= v6 is required!'
    finish
  endif

  set shell=pwsh
  let s:shcmd_flag = [
    \ '-NoLogo',
    \ '-NoProfile',
    \ '-ExecutionPolicy',
    \ 'RemoteSigned',
    \ '-Command',
    \ '[Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;',
  \ ]
  let &shellcmdflag = join(s:shcmd_flag, ' ')
  let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  set shellquote= shellxquote=
endif

" }}}

" Function and map {{{

let mapleader='\'

nnoremap <leader>bf :buffers<CR>:buffer<Space>

" https://github.com/lilydjwg/dotvim/blob/19f6f8ea67150cb5498706912b770d3c736716f2/vimrc#L36
" 删除所有未显示且无修改的缓冲区以减少内存占用
function Lilydjwg_cleanbufs()
    for bufNr in filter(range(1, bufnr('$')),
            \ 'buflisted(v:val) && !bufloaded(v:val)')
        execute bufNr . 'bdelete'
    endfor
endfunction

" Use <TAB> to select the popup menu:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" ctrl+hjkl 移动窗口
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
" }}}

" 配色方案 {{{
if filereadable(expand('~/.vim/plugins.vim'))
    colorscheme onedark
else
    set background=dark
    colorscheme desert
endif
if &term == "linux"
    let g:airline_symbols_ascii = 1
    let g:airline_theme='base16_gruvbox_dark_hard'
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    let g:airline_symbols.colnr = ' col:'
    let g:airline_symbols.crypt = 'crypt'
    let g:airline_symbols.dirty = 'dirty'
else
    let g:airline_symbols_ascii = 0
    let g:airline_theme = 'onedark'
endif
" }}}

" Hack for Terminal {{{
" https://github.com/lilydjwg/dotvim/blob/19f6f8ea67150cb5498706912b770d3c736716f2/vimrc#L559
if has("gui_running")
    set mousemodel=popup
    " 有些终端不能改变大小
    set columns=88
    set lines=38
    set cursorline
elseif has("unix")
    set ambiwidth=single
    if $COLORTERM == 'truecolor'
        set cursorline
        set termguicolors
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    elseif &term =~ '256color\|nvim'
        set cursorline
    else
        " 在 Linux 文本终端下非插入模式显示块状光标
        if &term == "linux" || &term == "fbterm"
            exec "set t_ve+=\033[?6c"
            autocmd InsertEnter * exec "set t_ve-=\033[?6c"
            autocmd InsertLeave * exec "set t_ve+=\033[?6c"
        endif
        if &term == "fbterm"
            set cursorline
        elseif $TERMCAP =~ 'Co#256'
            set t_Co=256
            set cursorline
        endif
    endif
elseif has('win32') && exists('$CONEMUBUILD')
    " enable 256 colors in ConEmu on Win
    set term=xterm
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
    set cursorline
endif

" https://github.com/lilydjwg/dotvim/blob/19f6f8ea67150cb5498706912b770d3c736716f2/vimrc#L621
" bracketed paste mode support for tmux
if &term =~ '^screen\|^tmux' && exists('&t_BE')
    let &t_BE = "\033[?2004h"
    let &t_BD = "\033[?2004l"
    " t_PS and t_PE are key code options and they are special
    exec "set t_PS=\033[200~"
    exec "set t_PE=\033[201~"
endif
if &term =~ '^screen\|^tmux'
    " This may leave mouse in use by terminal application
    " exec "set t_RV=\033Ptmux;\033\033[>c\033\\"
    set ttymouse=sgr
    if &t_GP == ''
        " for getwinpos
        exec "set t_GP=\033Ptmux;\033\033[13t\033\\"
    endif
endif
" }}}

nmap ga <Plug>(UnicodeGA)

" Core Configuration {{{

filetype plugin on
filetype plugin indent on
if has('syntax') && !exists('g:syntax_on')
    syntax enable
endif

" timeout
set ttimeout
set timeoutlen=500
set ttimeoutlen=100

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
    try
        packadd! matchit
    catch /.*/
        runtime! macros/matchit.vim
    endtry
endif

" Disables mouse in insert mode
if has('mouse')
    set mouse=a
    set mouse-=i
endif
set number relativenumber
set modeline
set display=truncate,uhex
set nrformats=bin,hex
set suffixes+=.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

set wildignore+=*~,.*.swp,*.kate-swp                " swap files
set wildignore+=*.py[co],__pycache__                " Python files
set wildignore+=*.o,*.obj,*.so,*.exe,*.dll          " Compiled product
set wildignore+=.hg,.git,.svn                       " Version control
set wildignore+=*.aux,*.out,*.toc                   " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg      " binary images
set wildignore+=*.spl                               " compiled spelling word lists
set wildignore+=*.DS_Store,.AppleDouble,.LSOverride " macOS junk files
set wildignore+=.directory,.fuse_hidden*,.Trash-*   " Linux junk files
set wildignore+=*.rdb                               " Redis database file
set wildignore+=.nfs*                               " NFS temp file
set wildignore+=[._]*.un~                           " Vim Persistent undo
set wildignore+=System\ Volume\ Information         " Windiws junk files
"set wildignore+=_build                              " Sphinx build dir
"set wildignore+=*CACHE                              " django compressor cache

" 使用连接命令时，仅在 "." "?" "!" 之后插入一个空格
" 如设置为 `joinspaces`，则插入两个空格
set nojoinspaces

" 高亮显示当前行/列
set cursorline
set cursorcolumn
" 设置宽度提示
set colorcolumn=80,100,120
" 显示侧边栏（用于显示 mark/gitdiff/诊断信息）
set signcolumn=yes

" 在状态栏显示正在输入的命令
set showcmd

" 显示行号和列号
set ruler

set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set shiftround
set complete-=i
set smarttab
" Let backspace more friendly
set backspace=indent,eol,nostop

set langmenu=zh_CN.UTF-8
set helplang=cn
set termencoding=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,utf-16,gb18030,gbk,gb2312,cp936,big5,latin1
set fileformats=unix,dos,mac
" exclude CJK
set spelllang=en,cjk

set whichwrap=b,s,[,]

" Width for line breaking and vertical prompt line
set textwidth=120

" Use LF by default
set fileformat=unix
set fileformats=unix,dos

" 不根据 `textwidth` 自动回绕文本
set formatoptions-=t
" 根据 `textwidth` 自动回绕注释，自动插入注释前导符
set formatoptions+=c
" 插入模式下回车自动插入注释前导符
set formatoptions+=r
" 普通模式下按 o/O 自动插入注释前导符
set formatoptions+=o
" 允许 `gq` 排版注释
set formatoptions+=q
" 关闭 vi 兼容的自动回绕
set formatoptions-=v
" 如遇Unicode值大于255的文本，不必等到空格再折行
set formatoptions+=m
" 合并两行中文时，不在中间加空格
set formatoptions+=B
" 不要在单字母单词之后分行
set formatoptions+=1
if has("patch-7.3.541")
    " Vim 7.4
    " 在合适的场合，连接行时删除注释前导符
    set formatoptions+=j
endif

" Open code folding
set foldmethod=syntax

" 启用搜索结果计数
set shortmess-=S
if !has("patch-8.1.1270")
    try
        packadd! vim-searchindex
    catch /.*/
    endtry
endif

" Enable a visual menu when using TAB autocomplete in command mode
set wildmenu

" 首先尝试最长的，接着轮换补全项
set wildmode=longest:full,full

set completeopt+=longest
try
  set completeopt+=popup
  set completepopup=border:off
catch /.*/
endtry

" 延迟绘制（提升性能）
set lazyredraw

set ambiwidth=double

" 支持显示的最大组合字符数目（不影响编辑），仅用于 encoding 为 utf-8
" 缺省值为2，对大多数语言足矣，希伯来语需要4，最大值为6
" 特殊的组合符 emoji 应该需要6？
set maxcombine=4

" 显示tab和空格
"set list
" 设置tab和空格样式
set listchars=eol:$,tab:>-,nbsp:␣,trail:-

" Enable fast terminal connection.
set ttyfast

" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-
set tags=tags;/

" 移除将 = 认为是文件名的一部分
set isfname-==

" 组合字符一个个地删除
set delcombine

" https://github.com/lilydjwg/dotvim/blob/19f6f8ea67150cb5498706912b770d3c736716f2/vimrc#L546
set statusline=%n\ %<%f\ %LL\ %{&modified?'[+]':&modifiable\|\|&ft=~'^\\vhelp\|qf$'?'':'[-]'}%h%r%{&fenc=='utf-8'\|\|&fenc==''?'':'['.&fenc.']'}%{&ff=='unix'?'':'['.&ff.']'}%{&bomb?'[BOM]':''}%{&eol?'':'[noeol]'}%{&diff?'[diff]':''}%=\ 0x%-4.8B\ \ \ \ %-14.(%l,%c%V%)\ %P

set diffopt+=vertical,context:3,foldcolumn:0
if &diffopt =~ 'internal'
    " https://stackoverflow.com/questions/32365271/whats-the-difference-between-git-diff-patience-and-git-diff-histogram
    " https://bramcohen.livejournal.com/73318.html
    " https://stackoverflow.com/questions/19949526/examples-of-different-results-produced-by-the-standard-myers-minimal-patienc
    " https://arxiv.org/abs/1902.02467
    " https://github.com/vim/vim/commit/e828b7621cf9065a3582be0c4dd1e0e846e335bf
    set diffopt+=indent-heuristic,algorithm:histogram
endif

set guioptions=acit

if has('langmap') && exists('+langremap')
    " Prevent that the langmap option applies to characters that result from a
    " mapping.  If set (default), this may break plugins (but it's backward
    " compatible).
    set nolangremap
endif

try
    set matchpairs=(:),{:},[:],《:》,〈:〉,［:］,（:）,「:」,『:』,‘:’,“:”
catch /^Vim\%((\a\+)\)\=:E474/
endtry

" Avoid E363
" Maximum amount of memory (in Kbyte) to use for pattern matching.
" The maximum value is about 2000000, default value is 1000. 
set maxmempattern=2000000

if has('unix')
    autocmd FileType gitcommit execute 'setlocal dictionary+=/usr/share/dict/words complete+=k'
    autocmd FileType markdown execute 'setlocal dictionary+=/usr/share/dict/words complete+=k'
    autocmd FileType tex,latex execute 'setlocal dictionary+=/usr/share/dict/words complete+=k'
endif

" }}}

" 搜索设置 {{{

" 搜索时忽略大小写
set ignorecase

" 智能搜索大小写判断，默认忽略大小写，除非搜索内容包含大写字母
set smartcase


if has('extra_search')
    " 高亮搜索内容
    set hlsearch

    " 查找输入时动态增量显示查找结果
    if has('reltime')
        set incsearch
    endif

endif
" }}}

" Language {{{

fun! CPPFormatSettings()
    setlocal equalprg=clang-format
endfun

autocmd FileType c,cpp call CPPFormatSettings()

" }}}
