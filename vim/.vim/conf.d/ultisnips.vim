vim9script
# vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
# kate: space-indent on; indent-width 4; syntax vim;

# SPDX-License-Identifier: MPL-2.0
# SPDX-FileCopyrightText: Coelacanthus

g:UltiSnipsSnippetDirectories = [$HOME .. '/.vim/UltiSnips']
def g:UltiSnips_Complete(): string
    UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
                return "\<TAB>"
            endif
        endif
    endif
    return ""
enddef

def g:UltiSnips_Reverse(): string
    UltiSnips#JumpBackwards()
    if g:ulti_jump_backwards_res == 0
        return "\<C-P>"
    endif
    return ""
enddef

def UltiSnipsSetMap()
    if !exists("g:UltiSnipsJumpForwardTrigger")
        g:UltiSnipsJumpForwardTrigger = "<tab>"
    endif
    if !exists("g:UltiSnipsJumpBackwardTrigger")
        g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
    endif
    autocmd InsertEnter * execute "inoremap <silent> " . g:UltiSnipsExpandTrigger     . " <C-R>=g:UltiSnips_Complete()<cr>"
    autocmd InsertEnter * execute "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"
enddef
autocmd User JetpackRainbowPost call UltiSnipsSetMap()
