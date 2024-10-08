vim9script
# vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
# kate: space-indent on; indent-width 4;

# Language Server Configuration

highlight link LspInlayHintsParam Conceal
highlight link LspInlayHintsType Conceal
highlight link LspDiagVirtualTextError LspErrorText
highlight link LspDiagVirtualTextWarning LspWarningText
highlight link LspDiagVirtualTextInfo LspInformationText
highlight link LspDiagVirtualTextHint LspHintText
highlight link LspDiagInlineError LspErrorHighlight
highlight link LspDiagInlineWarning LspWarningHighlight
highlight link LspDiagInlineInfo LspInformationHighlight
highlight link LspDiagInlineHint LspHintHighlight

var lspOpts = {
    aleSupport: false,
    autoComplete: true,
    showDiagInBalloon: false,
    showDiagInPopup: false,
    showDiagOnStatusLine: false,
    showDiagWithSign: false,
    showDiagWithVirtualText: true,
    highlightDiagInline: true,
    diagVirtualTextAlign: 'above',
    semanticHighlight: true,
    showInlayHints: true,
    showSignature: true,
    snippetSupport: false,
    ultisnipsSupport: false,
    usePopupInCodeAction: false,
    useQuickfixForLocations: true,
    useBufferCompletion: true,
}
autocmd User LspSetup call LspOptionsSet(lspOpts)

var lspServers: list<dict<any>> = []

if executable('bash-language-server')
    lspServers += [{
        name: 'bashls',
        filetype: 'sh',
        path: 'bash-language-server',
        args: ['start'],
        features: {
            diagnostics: false
        },
    }]
endif

if executable('clangd')
    lspServers += [{
        name: 'clangd',
        filetype: ['c', 'cpp'],
        path: 'clangd',
        args: ['--background-index', '--clang-tidy'],
        features: {
            diagnostics: false
        },
    }]
endif

if executable('vscode-css-languageserver')
    lspServers += [{
        name: 'cssls',
        filetype: 'css',
        path: 'vscode-css-languageserver',
        args: ['--stdio'],
        features: {
            diagnostics: false
        },
    }]
endif

if executable('jdtls')
    lspServers += [{
        name: 'jdtls',
        filetype: 'java',
        path: 'jdtls',
        args: [],
        initializationOptions: {
            settings: {
                java: {
                    completion: {
                        filteredTypes: ["com.sun.*", "java.awt.*", "jdk.*", "org.graalvm.*", "sun.*", "javax.awt.*", "javax.swing.*"],
                    },
                },
            },
        },
        features: {
            diagnostics: false
        },
    }]
endif

if executable('fortls')
    lspServers += [{
        name: 'fortls',
        filetype: 'fortran',
        path: 'fortls',
        args: ['--use_signature_help', '--hover_signature'],
        features: {
            diagnostics: false
        },
    }]
endif

if executable('gopls')
    lspServers += [{
        name: 'gopls',
        filetype: ['go'],
        path: 'gopls',
        args: ['serve'],
        workspaceConfig: {
            gopls: {
                hints: {
                    assignVariableTypes: true,
                    compositeLiteralFields: true,
                    compositeLiteralTypes: true,
                    constantValues: true,
                    functionTypeParameters: true,
                    parameterNames: true,
                    rangeVariableTypes: true
                }
            }
        },
        features: {
            diagnostics: false
        },
    }]
endif

if executable('vscode-html-languageserver')
    lspServers += [{
        name: 'htmlls',
        filetype: ['html'],
        path: 'vscode-html-languageserver',
        args: ['--stdio'],
        features: {
            diagnostics: false
        },
    }]
endif

if executable('lua-language-server')
    lspServers += [{
        name: 'luals',
        filetype: ['lua'],
        path: 'lua-language-server',
        args: [],
        workspaceConfig: {
            Lua: {
                hint: {
                    enable: true,
                }
            }
        },
        features: {
            diagnostics: false
        },
    }]
endif

if executable('omnisharp')
    lspServers += [{
        name: 'omnisharp',
        filetype: ['cs'],
        path: 'omnisharp',
        args: ['--z', '--languageserver', '--encoding', 'utf-8'],
        features: {
            diagnostics: false
        },
    }]
endif

if executable('rust-analyzer')
    lspServers += [{
        name: 'rustanalyzer',
        filetype: ['rust'],
        path: 'rust-analyzer',
        args: [],
        syncInit: true,
        initializationOptions: {
            inlayHints: {
                typeHints: {
                    enable: true
                },
                parameterHints: {
                    enable: true
                },
                chainingHints: {
                    # Disable because vim9lsp doesn't support yet
                    # https://github.com/yegappan/lsp/issues/417
                    enable: false
                }
            },
            check: {
                command: "clippy"
            },
        }
    }]
endif

if executable('solargraph')
    lspServers += [{
        name: 'solargraph',
        filetype: ['ruby'],
        path: 'solargraph',
        args: ['stdio'],
        features: {
            diagnostics: false
        },
    }]
endif

if executable('typescript-language-server')
    lspServers += [{
        name: 'tsserver',
        filetype: ['javascript', 'typescript'],
        path: 'typescript-language-server',
        args: ['--stdio'],
        features: {
            diagnostics: false
        },
    }]
endif

if executable('vim-language-server')
    lspServers += [{
        name: 'vimls',
        filetype: ['vim'],
        path: 'vim-language-server',
        args: ['--stdio'],
        features: {
            diagnostics: false
        }
    }]
endif

if executable('qmlls6')
    lspServers += [{
        name: 'qmlls',
        path: 'qmlls6',
        filetype: ['qml'],
        features: {
            diagnostics: false
        },
    }]
endif

if executable('awk-language-server')
    lspServers += [{
        name: 'awk-language-server',
        path: 'awk-language-server',
        filetype: ['awk'],
        features: {
            diagnostics: false
        },
    }]
endif

if executable('crystalline')
    lspServers += [{
        name: 'crystalline',
        path: 'crystalline',
        args: ['--stdio'],
        filetype: ['crystal'],
        features: {
            diagnostics: false
        },
    }]
endif

if executable('beancount-language-server')
    lspServers += [{
        name: 'beancount-language-server',
        path: 'beancount-language-server',
        args: ['--stdio'],
        filetype: ['beancount'],
        features: {
            diagnostics: false
        },
    }]
endif

if executable('glslls')
    lspServers += [{
        name: 'glslls',
        path: 'glslls',
        args: ['--stdin'],
        filetype: ['glsl'],
        features: {
            diagnostics: false
        },
    }]
endif

if executable('marksman')
    lspServers += [{
        name: 'marksman',
        path: 'marksman',
        args: ['server'],
        filetype: ['markdown'],
        features: {
            diagnostics: false
        },
    }]
endif

if executable('millet')
    lspServers += [{
        name: 'millet',
        path: 'millet',
        filetype: ['sml'],
        features: {
            diagnostics: false
        },
    }]
endif

if executable('svls')
    lspServers += [{
        name: 'svls',
        path: 'svls',
        filetype: ['verilog'],
        features: {
            diagnostics: false
        },
    }]
endif

if executable('nixd')
    lspServers += [{
        name: 'nixd',
        path: 'nixd',
        filetype: ['nix'],
        features: {
            diagnostics: false
        },
    }]
elseif executable('nil')
    lspServers += [{
        name: 'nil',
        path: 'nil',
        filetype: ['nix'],
        features: {
            diagnostics: false
        },
    }]
endif

if executable('cmake-language-server')
    lspServers += [{
        name: 'cmake-language-server',
        path: 'cmake-language-server',
        filetype: ['cmake'],
        initializationOptions: {
            buildDirectory: 'build'
        },
        features: {
            diagnostics: false
        },
    }]
endif

if executable('dot-language-server')
    lspServers += [{
        name: 'dot-language-server',
        path: 'dot-language-server',
        args: ['--stdio'],
        filetype: ['dot'],
        features: {
            diagnostics: false
        },
    }]
endif

if executable('haskell-language-server-wrapper')
    lspServers += [{
        name: 'haskell-language-server',
        path: 'haskell-language-server-wrapper',
        args: ['lsp'],
        filetype: ['haskell'],
        features: {
            diagnostics: false
        },
    }]
endif

if executable('lemminx')
    lspServers += [{
        name: 'lemminx',
        path: 'lemminx',
        filetype: ['xml'],
        features: {
            diagnostics: false
        },
    }]
    autocmd FileType xml setlocal formatexpr=lsp#lsp#FormatExpr()
endif

if executable('metals')
    lspServers += [{
        name: 'metals',
        path: 'metals',
        filetype: ['scala', 'sbt'],
        initializationOptions: {
            isHttpEnabled: true
        },
        features: {
            diagnostics: false
        },
    }]
endif

if executable('ocaml-lsp')
    lspServers += [{
        name: 'ocaml-lsp',
        path: 'ocaml-lsp',
        filetype: ['ocaml'],
        features: {
            diagnostics: false
        },
    }]
endif

if executable('pylsp')
    lspServers += [{
        name: 'pylsp',
        path: 'pylsp',
        filetype: ['python'],
        features: {
            diagnostics: false
        },
    }]
endif

if executable('pyright-langserver')
    lspServers += [{
        name: 'pyright',
        path: 'pyright-langserver',
        args: ['--stdio'],
        filetype: ['python'],
        features: {
            diagnostics: false
        },
    }]
endif

if executable('R')
    lspServers += [{
        name: 'R language server',
        path: 'R',
        args: ['--slave', '-e', 'languageserver::run()'],
        filetype: ['r'],
        features: {
            diagnostics: false
        },
    }]
endif

if executable('racket-lsp')
    lspServers += [{
        name: 'racket-lsp',
        path: 'racket-lsp',
        filetype: ['racket'],
        features: {
            diagnostics: false
        },
    }]
endif

if executable('terraform-ls')
    lspServers += [{
        name: 'terraform-ls',
        path: 'terraform-ls',
        args: ['serve'],
        filetype: ['terraform'],
        features: {
            diagnostics: false
        },
    }]
endif

if executable('texlab')
    lspServers += [{
        name: 'texlab',
        path: 'texlab',
        filetype: ['plaintex', 'tex'],
        workspaceConfig: {
             texlab: {
                build: {
                    executable: 'latexmk',
                    args: []
                }
            }
        },
        features: {
            diagnostics: false
        },
    }]
endif

if executable('zls')
    lspServers += [{
        name: 'zls',
        path: 'zls',
        filetype: ['zig'],
        features: {
            diagnostics: false
        },
    }]
endif

if executable('typst-lsp')
    lspServers += [{
        name: 'typst-lsp',
        path: 'typst-lsp',
        filetype: ['typst'],
        features: {
            diagnostics: false
        },
    }]
endif

if executable('glslls')
    lspServers += [{
        name: 'glsl-language-server',
        path: 'glslls',
        args: ['--stdio'],
        filetype: ['glsl'],
        features: {
            diagnostics: false
        },
    }]
endif

if filereadable('/usr/lib/lua-emmy-language-server/EmmyLua-LS-all.jar')
    lspServers += [{
        name: 'EmmyLua',
        path: 'java',
        args: ['-cp', '/usr/lib/lua-emmy-language-server/EmmyLua-LS-all.jar', 'com.tang.vscode.MainKt'],
        filetype: ['glsl'],
        features: {
            diagnostics: false
        },
    }]
endif

autocmd User LspSetup call LspAddServer(lspServers)
