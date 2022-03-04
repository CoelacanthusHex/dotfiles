vim9script

# https://www.reddit.com/r/vim/comments/pknuot/comment/hc87htu/?utm_source=share&utm_medium=web2x&context=3
def GetVimIndent_fix()
    let ind = GetVimIndentIntern()
    let prev = getline(prevnonblank(v:lnum - 1))
    if prev =~ '\s[{[]\s*$' && prev =~ '\s*\\'
        let ind -= shiftwidth()
    endif
    return ind
enddef

setlocal indentexpr=GetVimIndent_fix()

# kate: space-indent on; indent-width 4;
