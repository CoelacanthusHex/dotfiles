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
    ignoreMissingServer: true,
}
autocmd User LspSetup call LspOptionsSet(lspOpts)

var lspServers: list<dict<any>> = [
    {
        name: 'bashls',
        filetype: 'sh',
        path: 'bash-language-server',
        args: ['start'],
        features: {
            diagnostics: false
        },
    },
    {
        name: 'clangd',
        filetype: ['c', 'cpp'],
        path: 'clangd',
        args: ['--background-index', '--clang-tidy'],
        features: {
            diagnostics: false
        },
    },
    {
        name: 'cssls',
        filetype: 'css',
        path: 'vscode-css-languageserver',
        args: ['--stdio'],
        features: {
            diagnostics: false
        },
    },
    {
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
    },
    {
        name: 'fortls',
        filetype: 'fortran',
        path: 'fortls',
        args: ['--use_signature_help', '--hover_signature'],
        features: {
            diagnostics: false
        },
    },
    {
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
    },
    {
        name: 'htmlls',
        filetype: ['html'],
        path: 'vscode-html-languageserver',
        args: ['--stdio'],
        features: {
            diagnostics: false
        },
    },
    {
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
    },
    {
        name: 'omnisharp',
        filetype: ['cs'],
        path: 'omnisharp',
        args: ['--z', '--languageserver', '--encoding', 'utf-8'],
        features: {
            diagnostics: false
        },
    },
    {
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
    },
    {
        name: 'solargraph',
        filetype: ['ruby'],
        path: 'solargraph',
        args: ['stdio'],
        features: {
            diagnostics: false
        },
    },
    {
        name: 'typescript-language-server',
        filetype: ['javascript', 'typescript'],
        path: 'typescript-language-server',
        args: ['--stdio'],
        features: {
            diagnostics: false
        },
    },
    {
        name: 'vimls',
        filetype: ['vim'],
        path: 'vim-language-server',
        args: ['--stdio'],
        features: {
            diagnostics: false
        }
    },
    {
        name: 'qmlls',
        path: 'qmlls6',
        filetype: ['qml'],
        features: {
            diagnostics: false
        },
    },
    {
        name: 'awk-language-server',
        path: 'awk-language-server',
        filetype: ['awk'],
        features: {
            diagnostics: false
        },
    },
    {
        name: 'crystalline',
        path: 'crystalline',
        args: ['--stdio'],
        filetype: ['crystal'],
        features: {
            diagnostics: false
        },
    },
    {
        name: 'beancount-language-server',
        path: 'beancount-language-server',
        args: ['--stdio'],
        filetype: ['beancount'],
        features: {
            diagnostics: false
        },
    },
    {
        name: 'glslls',
        path: 'glslls',
        args: ['--stdin'],
        filetype: ['glsl'],
        features: {
            diagnostics: false
        },
    },
    {
        name: 'marksman',
        path: 'marksman',
        args: ['server'],
        filetype: ['markdown'],
        features: {
            diagnostics: false
        },
    },
    {
        name: 'millet',
        path: 'millet',
        filetype: ['sml'],
        features: {
            diagnostics: false
        },
    },
    {
        name: 'svls',
        path: 'svls',
        filetype: ['verilog'],
        features: {
            diagnostics: false
        },
    },
    {
        name: 'nixd',
        path: 'nixd',
        filetype: ['nix'],
        features: {
            diagnostics: false
        },
    },
    {
        name: 'cmake-language-server',
        path: 'cmake-language-server',
        filetype: ['cmake'],
        initializationOptions: {
            buildDirectory: 'build'
        },
        features: {
            diagnostics: false
        },
    },
    {
        name: 'dot-language-server',
        path: 'dot-language-server',
        args: ['--stdio'],
        filetype: ['dot'],
        features: {
            diagnostics: false
        },
    },
    {
        name: 'haskell-language-server',
        path: 'haskell-language-server-wrapper',
        args: ['lsp'],
        filetype: ['haskell'],
        features: {
            diagnostics: false
        },
    },
    {
        name: 'lemminx',
        path: 'lemminx',
        filetype: ['xml'],
        features: {
            diagnostics: false
        },
    },
    {
        name: 'metals',
        path: 'metals',
        filetype: ['scala', 'sbt'],
        initializationOptions: {
            isHttpEnabled: true
        },
        features: {
            diagnostics: false
        },
    },
    {
        name: 'ocaml-lsp',
        path: 'ocaml-lsp',
        filetype: ['ocaml'],
        features: {
            diagnostics: false
        },
    },
    {
        name: 'ruff',
        path: 'ruff',
        args: ['server'],
        filetype: ['python'],
    },
    {
        name: 'R language server',
        path: 'R',
        args: ['--slave', '-e', 'languageserver::run()'],
        filetype: ['r'],
        features: {
            diagnostics: false
        },
    },
    {
        name: 'racket-lsp',
        path: 'racket-lsp',
        filetype: ['racket'],
        features: {
            diagnostics: false
        },
    },
    {
        name: 'terraform-ls',
        path: 'terraform-ls',
        args: ['serve'],
        filetype: ['terraform'],
        features: {
            diagnostics: false
        },
    },
    {
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
    },
    {
        name: 'zls',
        path: 'zls',
        filetype: ['zig'],
        features: {
            diagnostics: false
        },
    },
    {
        name: 'typst-lsp',
        path: 'typst-lsp',
        filetype: ['typst'],
        features: {
            diagnostics: false
        },
    },
    {
        name: 'glsl-language-server',
        path: 'glslls',
        args: ['--stdio'],
        filetype: ['glsl'],
        features: {
            diagnostics: false
        },
    },
    {
        name: 'EmmyLua',
        path: 'java',
        args: ['-cp', '/usr/lib/lua-emmy-language-server/EmmyLua-LS-all.jar', 'com.tang.vscode.MainKt'],
        filetype: ['glsl'],
        features: {
            diagnostics: false
        },
    },
    {
        name: 'yaml-language-server',
        path: 'yaml-language-server',
        args: ['--stdio'],
        filetype: ['yaml'],
        workspaceConfig: {
            yaml: {
                schemaStore: {
                    enable: true
                },
                schemas: {
                    "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json": [
                        "**/*docker-compose*.yaml"
                    ],
                    "https://json.schemastore.org/chart.json": [
                        "**helm/values*.yaml"
                    ]
                }
            }
        }
    },
]
autocmd User LspSetup call LspAddServer(lspServers)
if executable('lemminx')
	autocmd FileType xml setlocal formatexpr=lsp#lsp#FormatExpr()
endif
