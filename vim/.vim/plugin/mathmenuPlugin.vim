" mathmenuPlugin.vim
"   Author: Charles E. Campbell
"   Date:   Feb 04, 2016
"   Version: 4m	ASTRO-ONLY
" GetLatestVimScripts: 2723 1 :AutoInstall: math.vim
" ---------------------------------------------------------------------
"  Load Once: {{{1
if &cp
 finish
endif
let s:keepcpo               = &cpo
let g:loaded_mathmenuPlugin = "v4m"
set cpo&vim

" ---------------------------------------------------------------------
" DrChip Menu Support: {{{1
if has("gui_running") && has("menu") && &go =~# 'm'
 if !exists("g:DrChipTopLvlMenu")
  let g:DrChipTopLvlMenu= "DrChip."
 endif
 exe 'nmenu <silent> '.g:DrChipTopLvlMenu."MathKeys.Enable	:call mathmenu#StartMathMenu()\<cr>"
 exe 'imenu <silent> '.g:DrChipTopLvlMenu."MathKeys.Enable	\<c-o>:call mathmenu#StartMathMenu()\<cr>"
 exe 'vmenu <silent> '.g:DrChipTopLvlMenu."MathKeys.Enable	:\<c-u>call mathmenu#StartMathMenu()\<cr>gv"
 exe 'cmenu <silent> '.g:DrChipTopLvlMenu."MathKeys.Enable	\<c-u>call mathmenu#StartMathMenu()\<cr>:"
endif
com! MathStart :call mathmenu#StartMathMenu()

" ---------------------------------------------------------------------
"  Restore: {{{1
let &cpo= s:keepcpo
unlet s:keepcpo
" vim: ts=28 fdm=marker
