vim9script
# vim: set sw=4 ts=8 sts=4 et foldmethod=marker:
# kate: space-indent on; indent-width 4;

# Language Server Configuration

# use VIM native client (need 8.2.4780+)
g:lsp_use_native_client = 1

g:lsp_diagnostics_enabled = 0

if has("patch-9.0.0167")
    g:lsp_diagnostics_virtual_text_enabled = 1
    g:lsp_inlay_hints_enabled = 1
    hi link lspInlayHintsType Comment
    hi link lspInlayHintsParameter Comment
endif

g:lsp_semantic_enabled = 1

g:lsp_fold_enabled = 0

if executable('qmlls6')
    au User lsp_setup lsp#register_server({
      \  'name': 'qmlls',
      \  'cmd': ['qmlls6'],
      \  'allowlist': ['qml']
      \  })
endif
if executable('awk-language-server')
    au User lsp_setup lsp#register_server({
        \ 'name': 'awk-language-server',
        \ 'cmd': ['awk-language-server'],
        \ 'allowlist': ['awk'],
        \ })
endif
