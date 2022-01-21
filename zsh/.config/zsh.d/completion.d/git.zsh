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

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4; 
