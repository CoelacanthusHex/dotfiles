# ignore for editor
# https://github.com/MaskRay/Config/blob/master/home/.zshrc#L170
# ignore video files, audio files and compiled files
_ignore_video_files=(avi mkv rmvb wmv mp4 flv webm mov)
_ignore_audio_files=(mp3 flac ogg wav)
_ignore_compiled_files=(a dylib so rlib lib dll o pyc zwc zwc.old)
_ignore_files=()
_ignore_files+=($_ignore_video_files) && _ignore_files+=($_ignore_audio_files) && _ignore_files+=($_ignore_compiled_files) && \
zstyle ':completion:*:*:(vi|vim|nvim|emacs|nano):*:*files' ignored-patterns \
    "*.(#i)(${(j:|:)_ignore_files})"

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4; 
