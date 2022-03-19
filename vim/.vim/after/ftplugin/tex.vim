vim9script
vimtex#init()

if jetpack#tap('ddc.vim')
    autocmd User ddc_setup ddc#custom#patch_filetype(['tex'], 'sourceOptions', {
      \ 'omni': {
      \   'forceCompletionPattern': g:vimtex#re#deoplete
      \ },
      \ })
    autocmd User ddc_setup ddc#custom#patch_filetype(['tex'], 'sourceParams', {
      \ 'omni': {'omnifunc': 'vimtex#complete#omnifunc'},
      \ })
endif
