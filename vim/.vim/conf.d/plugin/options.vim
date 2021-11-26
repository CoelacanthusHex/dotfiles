" vim: set sw=4 ts=8 sts=4 et foldmethod=marker:

" Core Configuration {{{

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" Avoid side effects when it was already reset.
if &compatible
    set nocompatible
endif

if has('autocmd')
    filetype plugin on
    filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
    syntax enable
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
    runtime! macros/matchit.vim
endif

" Disables mouse in insert mode
if has('mouse')
    set mouse=nvchr
endif
set number
set modeline
set display=truncate,uhex
set nrformats=bin,hex
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.png,.jpg

" 高亮显示当前行/列
set cursorline
set cursorcolumn
" 总是显示侧边栏（用于显示 mark/gitdiff/诊断信息）
set signcolumn=yes

" 在状态栏显示正在输入的命令
set showcmd

" 自动缩进
set autoindent
set smartindent

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set complete-=i
set smarttab
" Let backspace more friendly
set bs=3

set langmenu=zh_CN.UTF-8
set helplang=cn
set termencoding=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,gb18030,gbk,gb2312,cp936
set fileformats=unix,dos,mac

" Width for line breaking and vertical prompt line
set textwidth=120
set colorcolumn=+0

" Use LF by default
set fileformat=unix
set fileformats=unix,dos

" 如遇Unicode值大于255的文本，不必等到空格再折行
set formatoptions+=m

" 合并两行中文时，不在中间加空格
set formatoptions+=B

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

" 显示tab和空格
set list
" 设置tab和空格样式
set lcs=tab:\|\ ,nbsp:%,trail:-

" Enable fast terminal connection.
set ttyfast

" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-
set tags=tags;/

" https://github.com/lilydjwg/dotvim/blob/19f6f8ea67150cb5498706912b770d3c736716f2/vimrc#L546
set statusline=%n\ %<%f\ %LL\ %{&modified?'[+]':&modifiable\|\|&ft=~'^\\vhelp\|qf$'?'':'[-]'}%h%r%{&fenc=='utf-8'\|\|&fenc==''?'':'['.&fenc.']'}%{&ff=='unix'?'':'['.&ff.']'}%{&bomb?'[BOM]':''}%{&eol?'':'[noeol]'}%{&diff?'[diff]':''}%=\ 0x%-4.8B\ \ \ \ %-14.(%l,%c%V%)\ %P

" 
set diffopt+=vertical,context:3,foldcolumn:0
if &diffopt =~ 'internal'
  set diffopt+=indent-heuristic,algorithm:patience
endif

set guioptions=acit

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
