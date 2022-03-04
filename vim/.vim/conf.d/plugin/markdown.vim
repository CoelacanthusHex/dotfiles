" vim: set sw=4 ts=8 sts=4 et foldmethod=marker:

" hack for markdown conceal links
let g:markdown_syntax_conceal = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" https://github.com/SidOfc/mkdx/issues/138
" hack for URL is not visible
let g:indentLine_concealcursor=""
let g:indentLine_conceallevel=2

let g:vim_markdown_fenced_languages = ['python', 'rust', 'cpp', 'c', 'haskell', 'scala', 'typescript', 'javascript', 'zsh', 'bash', 'go', 'toml', 'tex', 'markdown', 'vim', 'c++=cpp', 'viml=vim', 'ini=dosini', 'csharp=cs', 'java']

let g:vim_markdown_math = 1
" Highlight YAML front matter as used by Jekyll or Hugo.
let g:vim_markdown_frontmatter = 1
" Highlight TOML front matter as used by Hugo.
let g:vim_markdown_toml_frontmatter = 1

" Strikethrough uses two tildes. ~~Scratch this.~~
let g:vim_markdown_strikethrough = 1

" https://github.com/plasticboy/vim-markdown#do-not-automatically-insert-bulletpoints
" when use gq to format code, vim-markdown will insert bullets in every line
" don't use it in markdown file
" see https://github.com/plasticboy/vim-markdown/issues/232

" disable markdown fold
let g:vim_markdown_folding_disabled = 1
" kate: space-indent on; indent-width 4;
