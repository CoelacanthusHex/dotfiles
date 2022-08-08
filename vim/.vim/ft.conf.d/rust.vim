vim9script
# vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
# kate: space-indent on; indent-width 4;

# https://github.com/rust-lang/rust.vim#playpen-integration
if has("linux")
    g:rust_clip_command = 'xclip -selection clipboard'
# https://stackoverflow.com/questions/2842078/how-do-i-detect-os-x-in-my-vimrc-file-so-certain-configurations-will-only-appl
# https://vi.stackexchange.com/a/31796
elseif has("macunix") || has("osx") || has("osxdarwin")
    g:rust_clip_command = 'pbcopy'
endif

g:rust_conceal = 0
