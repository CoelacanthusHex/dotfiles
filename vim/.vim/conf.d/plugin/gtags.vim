vim9script
# vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
# kate: space-indent on; indent-width 4;

$GTAGSLABEL = 'native-pygments'
$GTAGSCONF = '/usr/share/gtags/gtags.conf'


# gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

# 所生成的数据文件的名称
g:gutentags_ctags_tagfile = '.tags'

# 同时开启 ctags 和 gtags 支持：
g:gutentags_modules = []
if executable('ctags')
    g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
    g:gutentags_modules += ['gtags_cscope']
endif

# 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
g:gutentags_cache_dir = expand('~/.cache/tags')

# 配置 ctags 的参数，老的 Exuberant-ctags 不能有 --extra=+q，注意
g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
g:gutentags_ctags_extra_args += ['--c-kinds=+px']

# 如果使用 universal ctags 需要增加下面一行，老的 Exuberant-ctags 不能加下一行
g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

# 禁用 gutentags 自动加载 gtags 数据库的行为
g:gutentags_auto_add_gtags_cscope = 0

# This is the configuration file for GNU GLOBAL vim plugin

nmap <F2> :copen<CR>
nmap <F4> :cclose<CR>
nmap <F5> :Gtags<SPACE>
nmap <F6> :Gtags -f %<CR>
nmap <F7> :GtagsCursor<CR>
nmap <F8> :Gozilla<CR>
nmap <C-j> :cn<CR>
nmap <C-k> :cp<CR>
nmap <C-]>] :GtagsCursor<CR>
g:Gtags_OpenQuickfixWindow = 1
