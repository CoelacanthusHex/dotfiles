" vim: set sw=4 ts=4 sts=4 et foldmethod=marker:

" Core Configuration {{{

" Make Vim more useful
set nocompatible

if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
    syntax enable
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
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

" 自动缩进
set autoindent
set smartindent

set backspace=indent,eol,start
set tabstop=8
set softtabstop=4
set shiftwidth=4
set noexpandtab
set complete-=i
set smarttab

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

" Enable fast terminal connection.
set ttyfast

" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-
set tags=tags;/

" https://github.com/lilydjwg/dotvim/blob/19f6f8ea67150cb5498706912b770d3c736716f2/vimrc#L546
set statusline=%n\ %<%f\ %LL\ %{&modified?'[+]':&modifiable\|\|&ft=~'^\\vhelp\|qf$'?'':'[-]'}%h%r%{&fenc=='utf-8'\|\|&fenc==''?'':'['.&fenc.']'}%{&ff=='unix'?'':'['.&ff.']'}%{&bomb?'[BOM]':''}%{&eol?'':'[noeol]'}%{&diff?'[diff]':''}%=\ 0x%-4.8B\ \ \ \ %-14.(%l,%c%V%)\ %P

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
    set incsearch
endif
" }}}
