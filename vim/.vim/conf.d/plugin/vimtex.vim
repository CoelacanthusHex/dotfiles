vim9script
# vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
# kate: space-indent on; indent-width 4;

g:vimtex_enabled = 1
g:vimtex_fold_enabled = 1
g:vimtex_compiler_latexmk = {
                'options' : [
                  '-xelatex',
                  '-shell-escape',
                ],
            }
g:tex_flavor = 'latex'

g:matchup_override_vimtex = 1
