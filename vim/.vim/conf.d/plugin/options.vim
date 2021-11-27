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
    set mouse=a
    set mouse-=i
endif
set number
set modeline
set display=truncate,uhex
set nrformats=bin,hex
set suffixes+=.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set wildignore+=*~,*.py[co],__pycache__,.*.swp

" 使用连接命令时，仅在 "." "?" "!" 之后插入一个空格
" 如设置为 `joinspaces`，则插入两个空格
set nojoinspaces

" 高亮显示当前行/列
set cursorline
set cursorcolumn
" 显示侧边栏（用于显示 mark/gitdiff/诊断信息）
try
    set signcolumn=number
catch /.*/
endtry

" 在状态栏显示正在输入的命令
set showcmd

" 显示行号和列号
set ruler

set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab
set complete-=i
set smarttab
" Let backspace more friendly
set backspace=indent,eol,nostop

set langmenu=zh_CN.UTF-8
set helplang=cn
set termencoding=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,gb18030,gbk,gb2312,cp936,latin1
set fileformats=unix,dos,mac

set whichwrap=b,s,[,]

" Width for line breaking and vertical prompt line
set textwidth=120
set colorcolumn=+0

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
try
    " Vim 7.4
    " 在合适的场合，连接行时删除注释前导符
    set formatoptions+=j
catch /.*/
endtry

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
set list
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
