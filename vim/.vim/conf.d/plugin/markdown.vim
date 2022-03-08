vim9script
# vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
# kate: space-indent on; indent-width 4;

# hack for markdown conceal links
g:markdown_syntax_conceal = 0
g:vim_markdown_conceal = 0
g:vim_markdown_conceal_code_blocks = 0

# https://github.com/SidOfc/mkdx/issues/138
# hack for URL is not visible
g:indentLine_concealcursor=""
g:indentLine_conceallevel=2

g:vim_markdown_fenced_languages = ['python', 'rust', 'cpp', 'c', 'haskell', 'scala', 'typescript', 'javascript', 'js=javascript', 'javascriptreact', 'zsh', 'bash', 'go', 'toml', 'tex', 'markdown', 'vim', 'c++=cpp', 'viml=vim', 'ini=dosini', 'csharp=cs', 'java']

g:vim_markdown_math = 1
# Highlight YAML front matter as used by Jekyll or Hugo.
g:vim_markdown_frontmatter = 1
# Highlight TOML front matter as used by Hugo.
g:vim_markdown_toml_frontmatter = 1

# Strikethrough uses two tildes. ~~Scratch this.~~
g:vim_markdown_strikethrough = 1

# https://github.com/plasticboy/vim-markdown#do-not-automatically-insert-bulletpoints
# when use gq to format code, vim-markdown will insert bullets in every line
# don't use it in markdown file
# see https://github.com/plasticboy/vim-markdown/issues/232

# disable markdown fold
g:vim_markdown_folding_disabled = 1
# kate: space-indent on; indent-width 4;
