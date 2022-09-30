_video_files=(avi mkv rmvb wmv mp4 flv webm mov)
_audio_files=(mp3 flac ogg wav)
_av_files=()
_av_files+=($_video_files) && _av_files+=($_audio_files)
zstyle ':completion:*:*:mpv:*:*' file-patterns \
    "*.(#i)(${(j:|:)_av_files})"

zstyle ':completion:*:*:(flashplayer|ruffle):*' file-patterns '*.swf'
zstyle ':completion:*:*:hp2ps:*' file-patterns '*.hp'
zstyle ':completion:*:*:feh:*' file-patterns '*.{png,gif,jpg,svg}:images:images *(-/):directories:directories'
zstyle ':completion:*:*:imv:*' file-patterns '*.{png,gif,jpg,svg,tiff,psd}:images:images *(-/):directories:directories'
zstyle ':completion:*:*:timidity:*' file-patterns '*.mid'
zstyle ':completion:*:*:pdf2ps:*' file-patterns \
  '*.pdf:pdf-files:pdf\ files *(#q-/):directories:directories'

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4; 
