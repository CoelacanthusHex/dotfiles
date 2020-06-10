" Language Server Configuration

let g:LanguageClient_autoStart = 1
let g:LanguageClient_autoStop = 1

" the suddennly popup of diagnostics sign is kind of annoying
let g:LanguageClient_diagnosticsSignsMax = 0

" Use an absolute configuration path if you want system-wide settings
let g:LanguageClient_loadSettings = 1 
let g:LanguageClient_settingsPath = '~/.config/nvim/settings.json'

let g:LanguageClient_serverCommands = {
    \ 'c': ['/usr/bin/ccls', '--log-file=/tmp/cc.log'],
    \ 'cpp': ['/usr/bin/ccls', '--log-file=/tmp/cc.log'],
    \ 'cuda': ['/usr/bin/ccls', '--log-file=/tmp/cc.log'],
    \ 'objc': ['/usr/bin/ccls', '--log-file=/tmp/cc.log'],
    \ 'rust': ['rls'],
    \ 'typescript': ['/usr/bin/javascript-typescript-stdio'],
    \ 'javascript': ['/usr/bin/javascript-typescript-stdio'],
    \ 'haskell': ['hie-wrapper', '--lsp'],
    \ 'latex': ['texlab'],
    \ 'tex': ['texlab']
    \ }
