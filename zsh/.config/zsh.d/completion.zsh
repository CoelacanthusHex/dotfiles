zmodload zsh/complist

# using hjkl to select completion menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

autoload -Uz compinit
compinit -d "$ZSH_COMPDUMP"

autoload -U +X bashcompinit && bashcompinit
#[ -f /usr/share/bash-completion/bash_completion ] && source /usr/share/bash-completion/bash_completion
#(( $+commands[stack] )) && eval "$(stack --bash-completion-script stack)"

# enable hidden files completion
_comp_options+=(globdots)

# Some functions, like _apt and _dpkg, are very slow. We can use a cache in
# order to speed things up
zstyle ':completion:*' use-cache yes
_cache_dir=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcache
zstyle ':completion:*' cache-path $_cache_dir
unset _cache_dir

# ignore duplicate entries
zstyle ':completion:*:history-words'   remove-all-dups yes
zstyle ':completion:*:history-words'   stop yes

# define files to ignore for zcompile
zstyle ':completion:*:*:zcompile:*'    ignored-patterns '(*~|*.zwc)'
zstyle ':completion:correct:'          prompt 'correct to: %e'

# ignore completion functions for commands you don't have:
zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'

# correct case
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'

###  Color setting
# I use http://jafrog.com/2013/11/23/colors-in-terminal.html to get color code
# colorfull completion list
#eval $(dircolors -b) # Load better one in config.zsh
export ZLSCOLORS="${LS_COLORS}"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
# https://thevaluable.dev/zsh-completion-guide-examples/
# 描述显示为淡色
# it only supported by gnome-terminal
# https://gist.github.com/inexorabletash/9122583
#zstyle ':completion:*:descriptions' format $'\e[2m -- %d --\e[0m'
zstyle ':completion:*:descriptions' format '%F{blue} -- %d -- %f'
zstyle ':completion:*:messages' format '%F{purple} -- %d -- %f'
# 警告显示为红色
zstyle ':completion:*:warnings' format '%F{red}%B -- No Matches Found --%b%f'
zstyle ':completion:*:corrections' format '%F{yellow}%B -- %d (errors: %e) --%b%f'

#错误校正
zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
# _extensions 为 *. 补全扩展名
# 在最后尝试使用文件名
if is-at-least 5.0.5; then
    zstyle ':completion:*' completer _complete _extensions _match _approximate _expand_alias _ignored _files
else
    zstyle ':completion:*' completer _complete _match _approximate _expand_alias _ignored _files
fi

# allow one error for every three characters typed in approximate completer
zstyle ':completion:*:approximate:'    max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'

zstyle ':completion:*' expand 'yes'
# I don't like expand `//` -> `/*/`, I user `//` -> `/` as default behavior in UNIX
zstyle ':completion:*' squeeze-shlashes 'yes'
zstyle ':completion::complete:*' '\\'

zstyle ':completion:*' menu select
# 分组显示
zstyle ':completion:*' group-name ''

# 在 alias 之后补全(即把 alias 展开后补全而不是当中单独的命令)
unsetopt complete_aliases

# https://github.com/lilydjwg/dotzsh/blob/master/zshrc#L306-L312
# 插入当前的所有补全 https://www.zsh.org/mla/workers/2020/index.html {{{2
zstyle ':completion:all-matches::::' completer _all_matches _complete
zstyle ':completion:all-matches:*' old-matches true
zstyle ':completion:all-matches:*' insert true
zstyle ':completion:all-matches:*' file-patterns '%p:globbed-files' '*(-/):directories' '*:all-files'
zle -C all-matches complete-word _generic
bindkey '^Xi' all-matches

### Autosuggest Setting
export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)
export ZSH_AUTOSUGGEST_USE_ASYNC=true
# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
    OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
    zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}
pastefinish() {
    zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
# https://github.com/zsh-users/zsh-autosuggestions/issues/351
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste accept-line)

_ZSH_PLUGINS="/usr/share/zsh/plugins"
_enabled_plugins=(
    zsh-autosuggestions
    zsh-history-substring-search
    zsh-syntax-highlighting
)
for _zsh_plugin in $_enabled_plugins[@]; do
    [[ ! -r "$_ZSH_PLUGINS/$_zsh_plugin/$_zsh_plugin.zsh" ]] || source $_ZSH_PLUGINS/$_zsh_plugin/$_zsh_plugin.zsh
done

# https://github.com/zsh-users/zsh-history-substring-search#usage
zmodload zsh/terminfo
#bindkey "$terminfo[kcuu1]" history-substring-search-up
#bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
export HISTORY_SUBSTRING_SEARCH_PREFIXED=true


# kill 命令补全
compdef pkill=kill
compdef pkill=killall
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes' command 'ps -afu$USER'
# Provide more processes in completion of programs like killall:
zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'

# complete manual by their section, from grml
zstyle ':completion:*:manuals'    separate-sections true
zstyle ':completion:*:manuals.*'  insert-sections   true

# 在 .. 后不要回到当前目录
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# complete user-commands for git-*
# https://pbrisbin.com/posts/deleting_git_tags_with_style/
# /usr/share/zsh/functions/Completion/Unix/_git
#zstyle ':completion:*:*:git:*' user-commands ${${(M)${(k)commands}:#git-*}/git-/}
# we can add all git-* subcommand without description using command above,
# but we can add each git-* subcommand with description using command below
(( $+commands[git-clang-format] )) && zstyle ':completion:*:*:git:*' user-commands clang-format:'format files between two commits.(If only 1/0, between workspace and <commit>(default: HEAD) )'
(( $+commands[git-filter-repo] )) && zstyle ':completion:*:*:git:*' user-commands filter-repo:'rapidly rewrite entire repository history using user-specified filters'
(( $+commands[git-lfs] )) && zstyle ':completion:*:*:git:*' user-commands lfs:'managing and versioning large files in association with a Git repository'
(( $+commands[git-review] )) && zstyle ':completion:*:*:git:*' user-commands review:'help submitting git branches to Gerrit for review'
(( $+commands[git-latexdiff] )) && zstyle ':completion:*:*:git:*' user-commands latexdiff:'call latexdiff on two Git revisions of a file. (latexdiff [old] [new], new defaults to HEAD, -- is workspace)'
(( $+commands[git-sizer] )) && zstyle ':completion:*:*:git:*' user-commands sizer:'compute various size metrics for a Git repository, flagging those that might cause problems'
(( $+commands[git-cliff] )) && zstyle ':completion:*:*:git:*' user-commands cliff:'highly customizable changelog generator'
(( $+commands[git-absorb] )) && zstyle ':completion:*:*:git:*' user-commands absorb:'automatically absorb staged changes into your current branch'
(( $+commands[git-crypt] )) && zstyle ':completion:*:*:git:*' user-commands crypt:'transparent file encryption in git'
(( $+commands[git-revise] )) && zstyle ':completion:*:*:git:*' user-commands revise:'rebase staged changes onto the given commit, and rewrite history to incorporate these changes'
# git-extras will add completion in file below as command above
[[ ! -r "/usr/share/doc/git-extras/git-extras-completion.zsh" ]] || source /usr/share/doc/git-extras/git-extras-completion.zsh

# disable fallback to filename completion
zstyle ':completion:*:*:git*:*' use-fallback false

# Search path for sudo completion
zstyle ':completion:*:sudo:*' command-path  /usr/local/sbin \
                                            /usr/local/bin  \
                                            /usr/sbin       \
                                            /usr/bin        \
                                            /sbin           \
                                            /bin            \
                                            /usr/X11R6/bin

zstyle :compinstall filename "${HOME}/.zshrc"

compdef downgrade=pactree 2>/dev/null
compdef proxychains=command
compdef prime-run=command
compdef cgproxy=command

# FIXME: Add LLVM completions, and remove it when upstream inculde
# clang-doc clang-include-fixer clangd-indexer clang-format clangd has special in completions/
# TODO: diagtool, hmaptool use subcommand, I need write for it
compdef _gnu_generic clang-tidy analyze-build clang-apply-replacements clang-change-namespace clang-check clang-extdef-mapping clang-move clang-offload-bundler clang-offload-wrapper clang-query clang-refactor clang-rename clang-reorder-fields clang-repl clang-scan-deps find-all-symbols intercept-build modularize pp-trace run-clang-tidy scan-build scan-build-py scan-view
# llvm-config llvm-dwarfdump has special in completions/
compdef _gnu_generic llvm-addr2line llvm-cat llvm-cvtres llvm-dis llvm-extract llvm-jitlink-executor llvm-lto llvm-modextract llvm-opt-report llvm-profgen llvm-reduce llvm-stress llvm-tblgen llvm-ar llvm-cfi-verify llvm-cxxdump llvm-dlltool llvm-gsymutil llvm-lib llvm-lto2 llvm-mt llvm-otool llvm-ranlib llvm-rtdyld  llvm-strings llvm-undname llvm-as llvm-cxxfilt llvm-ifs llvm-libtool-darwin llvm-mc llvm-nm llvm-pdbutil llvm-rc llvm-sim llvm-strip llvm-windres llvm-bcanalyzer llvm-cov llvm-cxxmap llvm-dwp llvm-install-name-tool llvm-link llvm-objcopy llvm-PerfectShuffle llvm-readelf llvm-size llvm-symbolizer llvm-xray llvm-bitcode-strip llvm-c-test llvm-diff llvm-exegesis llvm-jitlink llvm-lipo llvm-ml llvm-profdata llvm-readobj llvm-split llvm-tapi-diff dsymutil llvm-dsymutil llvm-mca llvm-objdump
compdef _gnu_generic FileCheck bugpoint lit llc lli lli-child-target obj2yaml opt sancov sanstats split-file verify-uselistorder yaml-bench yaml2obj

compdef _gnu_generic ccls
compdef _gnu_generic mill amm
compdef _gnu_generic updatedb plocate
compdef _gnu_generic btrfs-list

zstyle ':completion:*:*:x:*' file-patterns \
    '*.(#i)(tar.gz|tgz|tar.bz2|tbz|tbz2|tar.xz|txz|tar.zma|tlz|tar.zst|tzst|tar.lz|tar.lz4|tar.lrz|tar|cbt|gz|bz2|xz|lrz|lz4|lzma|z|Z|zip|war|jar|ear|sublime-package|ipa|ipsw|xpi|apk|aar|whl|cbz|epub|maff|rar|cbr|rpm|7z|chm|cb7|deb|zst|exe|cab|cpio|cba|ace|zpaq|arc)(-.):compressed-files:"compressed files" *(-/):directories:directories'

# remove svg from feh completion list because it need a parameter `--conversion-timeout 1`
zstyle ':completion:*:*:feh:*' file-patterns '*.(#i)(png|gif|jpg|jpeg|webp)(-.):images:images *(-/):directories:directories'
zstyle ':completion:*:*:viu:*' file-patterns '*.(#i)(png|gif|jpg|jpeg|webp)(-.):images:images *(-/):directories:directories'
# TODO: add *.svg to `display` completion list
zstyle ':completion:*:*:inkview:*' file-patterns '*.(#i)(svg)(-.):images:"vector images" *(-/):directories:directories'
_pic_viewer_formats=(png gif jpg jpeg tiff bmp webp avif)
zstyle ':completion:*:*:pic-viewer:*' file-patterns "*.(#i)(${(j:|:)_pic_viewer_formats})(-.):images:images *(-/):directories:directories"
unset _pic_viewer_formats
zstyle ':completion:*:*:svg-viewer:*' file-patterns '*.(#i)(svg)(-.):images:"vector images" *(-/):directories:directories'
zstyle ':completion:*:*:mpv:*' file-patterns \
    '*.(#i)(flv|mp4|webm|mkv|wmv|mov|avi|mp3|ogg|wma|flac|wav|aiff|m4a|m4b|m4v|gif|ifo)(-.) *(-/):directories' '*:all-files'
zstyle ':completion::complete:evince:*' file-patterns '*.{pdf,ps,eps,dvi,djvu,pdf.gz,ps.gz,dvi.gz}:documents:documents *(-/):directories:directories'
zstyle ':completion::complete:okular:*' file-patterns '*.{pdf,ps,eps,dvi,djvu,pdf.gz,ps.gz,dvi.gz}:documents:documents *(-/):directories:directories'

# ignore for editor
# https://github.com/MaskRay/Config/blob/master/home/.zshrc#L170
# ignore video files, audio files and compiled files
_ignore_video_files=(avi mkv rmvb wmv mp4 flv webm mov)
_ignore_audio_files=(mp3 flac ogg wav)
_ignore_compiled_files=(a dylib so rlib lib o pyc zwc)
_ignore_files=()
_ignore_files+=($_ignore_video_files) && _ignore_files+=($_ignore_audio_files) && _ignore_files+=($_ignore_compiled_files) && \
zstyle ':completion:*:*:(vi|vim|nvim|emacs|nano):*:*files' ignored-patterns \
    "*.(${(j:|:)_ignore_files})(-.)"

# Ignore pyc files for python
zstyle ':completion:*:*:(python*|pytest):*:*files' ignored-patterns '*.(pyc)(-.)'

# https://github.com/zsh-users/zsh/blob/zsh-5.8/Completion/Unix/Command/_ipsec#L6-L8
#zstyle ':completion:*:(ipsec|strongswan)/*' gain-privileges yes
# https://github.com/zsh-users/zsh/blob/zsh-5.8/Completion/Unix/Command/_swanctl#L6-L8
#zstyle ':completion:*:swanctl/*' gain-privileges yes

# By default only C and C++ languages are supported for compiler flag variables. To define your own list of languages:
#cmake_langs=('C' 'C' 'CXX' 'C++')
#zstyle ':completion:*:cmake:*' languages $cmake_langs

# Mutt Address Book
[[ -r ~/.config/mutt/muttrc.aliases ]] && zstyle ':completion:*:mutt:*' users ${${${(f)"$(<~/.config/mutt/muttrc.aliases)"}#alias[[:space:]]}%%[[:space:]]*}

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4;
