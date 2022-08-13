vim9script
# vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
# kate: space-indent on; indent-width 4;

# always attach to COMMIT_EDITMSG
g:committia_open_only_vim_starting = 1

g:committia_hooks = {}
def Committia_hooks_edit_open(info: any)
    # Additional settings
    setlocal spell

    # If no commit message, start with insert mode
    if info.vcs ==# 'git' && getline(1) ==# ''
        startinsert
    endif
enddef

g:committia_hooks["edit_open"] = Committia_hooks_edit_open
