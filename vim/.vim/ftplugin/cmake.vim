vim9script
# vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
# kate: space-indent on; indent-width 4; syntax vim;

setlocal keywordprg=:CMakeHelpPopup

import autoload 'cmakehelp.vim'

setlocal ballooneval
setlocal balloonevalterm
setlocal balloonexpr=cmakehelp.Balloonexpr()
