" vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
" Language Server Configuration

let g:ycm_language_server = [
            \   {
            \     'name': 'latex',
            \     'cmdline': ['texlab'],
            \     'filetypes': ['latex']
            \   },
            \   {
            \     'name': 'tex',
            \     'cmdline': ['texlab'],
            \     'filetypes': ['tex']
            \   },
            \   {
            \    'name': 'ccls',
            \    'cmdline': ['ccls'],
            \    'filetypes': ['c', 'cpp', 'cuda', 'objc', 'objcpp'],
            \    'project_root_files': ['.ccls-root', 'compile_commands.json']
            \   },
            \   {
            \     'name': 'scala',
            \     'filetypes': ['scala'],
            \     'cmdline': ['metals-vim'],
            \     'project_root_files': ['build.sbt', 'build.sc']
            \   },
            \   {
            \     'name': 'haskell-language-server',
            \     'cmdline': ['haskell-language-server-wrapper', '--lsp'],
            \     'filetypes': ['haskell', 'lhaskell'],
            \     'project_root_files': ['stack.yaml', 'cabal.project', 'package.yaml', 'hie.yaml'],
            \   },
            \   {
            \     'name': 'bash',
            \     'cmdline': ['bash-language-server', 'start'],
            \     'filetypes': ['sh', 'bash'],
            \   },
            \   {
            \     'name': 'xml',
            \     'cmdline': ['lemminx'],
            \     'filetypes': ['xml'],
            \   },
            \   {
            \     'name': 'systemverilog',
            \     'cmdline': ['svls'],
            \     'filetypes': ['systemverilog'],
            \   },
            \ ]
" https://github.com/bash-lsp/bash-language-server/issues/252
