# remove svg from feh completion list because it need a parameter `--conversion-timeout 1`
zstyle ':completion:*:*:feh:*' file-patterns '*.(#i)(png|gif|jpg|jpeg|webp)(.-):images:images *(-/):directories:directories'
zstyle ':completion:*:*:viu:*' file-patterns '*.(#i)(png|gif|jpg|jpeg|webp)(.-):images:images *(-/):directories:directories'
# TODO: add *.svg to `display` completion list
zstyle ':completion:*:*:inkview:*' file-patterns '*.(#i)svg(.-):images:"vector images" *(-/):directories:directories'
#_pic_viewer_formats=(png gif jpg jpeg tiff bmp webp avif)
#zstyle ':completion:*:*:pic-viewer:*' file-patterns "*.(#i)(${(j:|:)_pic_viewer_formats}):images:images *(-/):directories:directories"
#unset _pic_viewer_formats
#zstyle ':completion:*:*:svg-viewer:*' file-patterns '*.(#i)svg:images:"vector images" *(-/):directories:directories'
zstyle ':completion:*:*:mpv:*' file-patterns \
    '*.(#i)(flv|mp4|webm|mkv|wmv|mov|avi|mp3|ogg|wma|flac|wav|aiff|m4a|m4b|m4v|gif|ifo)(.-) *(-/):directories' '*:all-files'
zstyle ':completion::complete:evince:*' file-patterns '*.{pdf,ps,eps,dvi,djvu,pdf.gz,ps.gz,dvi.gz}:documents:documents *(-/):directories:directories'
zstyle ':completion::complete:okular:*' file-patterns '*.{pdf,ps,eps,dvi,djvu,pdf.gz,ps.gz,dvi.gz}:documents:documents *(-/):directories:directories'

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4; 
