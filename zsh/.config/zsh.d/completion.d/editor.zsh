# ignore for editor
# https://github.com/MaskRay/Config/blob/master/home/.zshrc#L170
# ignore video files, audio files and compiled files
# https://github.com/romkatv/zsh4humans/blob/fd101ce997d8434668af517cc159e3ab42c0ff30/fn/-z4h-compinit#L13
local -aU editors=(
  vi vim nvim emacs nano gedit code kak kate mcedit joe $EDITOR $VISUAL
  bat cat less more $PAGER)
_ignore_video_files=(avi mkv rmvb wmv mp4 flv webm mov)
_ignore_audio_files=(mp3 flac ogg wav)
_ignore_compiled_files=(exe a dylib so rlib lib dll o pyc zwc zwc.old img apk)
_ignore_files=()
_ignore_files+=($_ignore_video_files) && _ignore_files+=($_ignore_audio_files) && _ignore_files+=($_ignore_compiled_files) && \
zstyle ':completion:*:*:('${(j:|:)editors}'):*:*' ignored-patterns \
    "*.(#i)(${(j:|:)_ignore_files})"

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4; 
