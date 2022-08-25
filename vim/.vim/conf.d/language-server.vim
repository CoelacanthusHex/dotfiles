vim9script
# vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
# kate: space-indent on; indent-width 4;

# Language Server Configuration

g:ycm_language_server = [
            {
              name: 'latex',
              cmdline: ['texlab'],
              filetypes: ['latex']
            },
            {
              name: 'tex',
              cmdline: ['texlab'],
              filetypes: ['tex']
            },
            {
             name: 'clangd',
             cmdline: ['clangd'],
             filetypes: ['c', 'cpp', 'cuda', 'objc', 'objcpp'],
             project_root_files: ['compile_commands.json']
            },
            {
              name: 'scala',
              filetypes: ['scala'],
              cmdline: ['metals-vim'],
              project_root_files: ['build.sbt', 'build.sc', 'build.gradle', 'pom.xml']
            },
            {
              name: 'haskell-language-server',
              cmdline: ['haskell-language-server-wrapper', '--lsp'],
              filetypes: ['haskell', 'lhaskell'],
              project_root_files: ['stack.yaml', 'cabal.project', 'package.yaml', 'hie.yaml'],
            },
            {
              name: 'bash',
              cmdline: ['bash-language-server', 'start'],
              filetypes: ['sh', 'bash'],
            },
            {
              name: 'xml',
              cmdline: ['lemminx'],
              filetypes: ['xml', 'xsd', 'svg'],
            },
            {
              name: 'systemverilog',
              cmdline: ['svls'],
              filetypes: ['verilog', 'systemverilog'],
            },
            {
              name: 'vim script',
              cmdline: ['vim-language-server', '--stdio'],
              filetypes: ['vim'],
            },
            ]
# https://github.com/bash-lsp/bash-language-server/issues/252
