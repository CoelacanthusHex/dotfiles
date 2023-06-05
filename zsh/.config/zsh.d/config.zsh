## Glob
# Enable extended glob
setopt extended_glob
# Disable `PATTERN(QUALIFIERS)`, extended_glob has `PATTERN(#qQUALIFIERS)`
unsetopt bare_glob_qual

## History
# Do not save duplicate history items
setopt hist_save_no_dups
setopt hist_ignore_dups
# If you add a space before a command, do not add this command to the log file
setopt hist_ignore_space
# better perf (since 4.3.6)
setopt hist_fcntl_lock
# Remove extra whitespace
setopt hist_reduce_blanks
# Add timestamp to commands in history
setopt extended_history
# Do not execute when expanding history
setopt hist_verify
# Do not share history instantly between instances
# Use `fc -IR` to read history `fc -IA` to save history
unsetopt share_history
# Write history in append mode
setopt append_history

## Directory
setopt auto_pushd
DIRSTACKSIZE=128
# Don't pushd duplicates
setopt pushd_ignore_dups
# Exchange the meanings of `+` and `-` in pushd
setopt pushd_minus
unsetopt autocd

## Interactive
# '' in single quotes means a ' (as in Vimscript)
setopt rc_quotes
# Disable history expansion
setopt nobanghist
# Enable multiple redirections
setopt multios
# Allows the use of comments in interactive mode. For example:
#cmd #commnet
setopt interactive_comments
# Make setopt output all options
setopt ksh_option_print
# Automatically continue the process after disown
setopt auto_continue
# Using c format hexadecimal number
setopt c_bases
# Disable for problems with parsing of, for example, date and time strings with leading zeroes
unsetopt octal_zeroes
# Error when no matched
setopt nomatch
# https://blog.lilydjwg.me/2015/7/26/a-simple-zsh-module.116403.html
# https://gist.github.com/lilydjwg/0bfa6807b88e6d39a995
zmodload zsh/subreap 2>/dev/null && subreap
unsetopt beep

# Disable tty flow control, allows vim to use '<Ctrl>S'
unsetopt flow_control && stty -ixon

# set tab size
tabs -4

# Others
autoload -Uz zmv
autoload -Uz zargs

bindkey -e
autoload -U edit-command-line
zle -N edit-command-line
bindkey "$_key[Ctrl+Alt+X]$_key[Ctrl+Alt+E]" edit-command-line

# set end of file mark
export PROMPT_EOL_MARK="%B%F{red}🔚"

# Help
unalias run-help 2> /dev/null
autoload -Uz run-help
alias help=run-help

autoload -Uz run-help-git
autoload -Uz run-help-ip
autoload -Uz run-help-openssl
autoload -Uz run-help-p4
autoload -Uz run-help-sudo
autoload -Uz run-help-svk
autoload -Uz run-help-svn

# Terminal Title
autoload -Uz add-zsh-hook

function set-xterm-terminal-title () {
    printf '\e]2;%s\a' "$@"
}

case ${TERM} in
    xterm*|rxvt*|Eterm|aterm|kterm|gnome*|konsole*)
        function precmd-set-terminal-title () {
            #set-xterm-terminal-title "${(%):-"%n@%m: %~"}"
            printf "\e]2;%s@%s: %s\a" "${USER}" "${HOST%%.*}" "${(D)PWD}"
        }
        function preexec-set-terminal-title () {
            #set-xterm-terminal-title "${(%):-"%n@%m: "}$2"
            printf "\e]2;%s@%s: %s\a" "${USER}" "${HOST%%.*}" "$2"
        }
        ;;
    screen*|tmux*)
        function precmd-set-terminal-title () {
            printf "\033_%s@%s: %s\033\\" "${USER}" "${HOST%%.*}" "${(D)PWD}"
        }
        function preexec-set-terminal-title () {
            printf "\033_%s@%s: %s\033\\" "${USER}" "${HOST%%.*}" "$2"
        }
        ;;
    *)
        function precmd-set-terminal-title () {
            set-xterm-terminal-title "${(%):-"%n@%m: %~"}"
        }
        
        function preexec-set-terminal-title () {
            set-xterm-terminal-title "${(%):-"%n@%m: "}$2"
        }
        ;;
esac

add-zsh-hook -Uz precmd precmd-set-terminal-title
add-zsh-hook -Uz preexec preexec-set-terminal-title

# https://archive.zhimingwang.org/blog/2015-09-21-zsh-51-and-bracketed-paste.html
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic

# better than copy-prev-word
bindkey "$_key[Ctrl+Alt+-]" copy-prev-shell-word

autoload -Uz colors && colors

() {
    local cyan=$fg_bold[cyan] blue=$fg_bold[blue] rst=$reset_color
    #local white_b=$'\e[97m' blue=$'\e[94m' rst=$'\e[0m'
    TIMEFMT="
== TIME REPORT FOR $cyan%J$rst ==
  User Time:            $blue%U$rst
  System Time:          $blue%S$rst
  Total Time:           $blue%*Es${rst}
  CPU:                  $blue%P$rst
  Mem:                  $blue%M KiB$rst
  Shared Mem:           $blue%X KiB$rst
  Unshared Mem:         $blue%D KiB$rst
  Page Fault From Disk: $blue%F$rst
  Other Page Fault:     $blue%R$rst"
}

SPROMPT="%B%F{yellow}zsh: correct '%R' be '%r' [nyae]?%f%b "

[[ "$COLORTERM" == (24bit|truecolor) || (( ${terminfo[colors]} == 16777216 )) ]] || zmodload zsh/nearcolor

# Basic LS_COLORS
(( $_in_gui == 1 )) || [[ -n "$ANDROID_ROOT" ]] || smartcache eval dircolors -b

# Extended LS_COLORS
smartcache eval dircolors -b "$ZDOTDIR/plugins/LS_COLORS"


# [Esc Esc] double click Esc to insert sudo before current/previous command
# https://github.com/lilydjwg/dotzsh/blob/313050449529c84914293283691da1e824d779f5/zshrc#L292
function sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    [[ $BUFFER != sudo\ * && $UID -ne 0 ]] && {
        typeset -a bufs
        bufs=(${(z)BUFFER})
        # disable expand aliases after sudo because we have enable aliases after sudo
        #while (( $+aliases[$bufs[1]] )); do
        #    local expanded=(${(z)aliases[$bufs[1]]})
        #    bufs[1,1]=($expanded)
        #    if [[ $bufs[1] == $expanded[1] ]]; then
        #        break
        #    fi
        #done
        bufs=(sudo $bufs)
        BUFFER=$bufs
    }
    zle end-of-line
}
zle -N sudo-command-line
bindkey "$_key[Esc]$_key[Esc]" sudo-command-line

# https://github.com/momo-lab/zsh-replace-multiple-dots/blob/master/replace-multiple-dots.plugin.zsh
function replace_multiple_dots() {
    local dots=$LBUFFER[-3,-1]
    if [[ $dots =~ "^[ //\"']?\.\.$" ]]; then
        LBUFFER=$LBUFFER[1,-3]'../.'
    fi
    zle self-insert
}
zle -N replace_multiple_dots
bindkey "." replace_multiple_dots

# [Ctrl+L] clear screen while maintaining scrollback
# https://blog.quarticcat.com/posts/how-do-i-make-my-zsh-smooth-as-fuck/
# https://superuser.com/questions/1389834
function _clear-screen() {
    # FIXME: works incorrectly in tmux
    local prompt_height=$(echo -n ${(%%)PS1} | wc -l)
    local lines=$((LINES - prompt_height))
    printf "$terminfo[cud1]%.0s" {1..$lines}  # cursor down
    printf "$terminfo[cuu1]%.0s" {1..$lines}  # cursor up
    zle .reset-prompt
}
zle -N _clear-screen
bindkey "$_key[Ctrl+L]" _clear-screen

function foreground-last-job () {
    if (( ${#jobstates} )); then
        zle .push-input
        [[ -o hist_ignore_space ]] && BUFFER=' ' || BUFFER=''
        BUFFER="${BUFFER}fg"
        zle .accept-line
    else
        zle -M 'No background jobs. Doing nothing.'
    fi
}
zle -N foreground-last-job

bindkey "$_key[Ctrl+Z]" foreground-last-job
bindkey -M emacs "$_key[Ctrl+Z]" foreground-last-job
bindkey -M viins "$_key[Ctrl+Z]" foreground-last-job

# add a command line to the shells history without executing it
function commit-to-history () {
    print -s ${(z)BUFFER}
    zle send-break
}
zle -N commit-to-history
# bindkey -M viins "^x^h" commit-to-history
# bindkey -M emacs "^x^h" commit-to-history

# [Space] Do history expansion
bindkey "$_key[Space]"  magic-space
# [Ctrl-Z] Undo
bindkey "$_key[Ctrl+Z]" undo
# [Ctrl-Y] Redo
bindkey "$_key[Ctrl+Y]" redo
# [Ctrl-N] Navigate by xplr
bindkey -s "$_key[Ctrl+N]" '^Q cd -- ${$(xplr):-.} \n'

# Enable aliases to be sudo’ed
# http://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
alias sudo='sudo '
alias cgproxy='cgproxy '

# bat using noexpandtab
(( $+commands[bat] )) && { (( $_in_linux_tty == 1 )) && export BAT_OPTS="--tabs 0 --theme 'Monokai Extended'" || export BAT_OPTS="--tabs 0 --theme 'Monokai Extended' --italic-text=always" }

# BSD ls colors.
export LSCOLORS='exfxcxdxbxGxDxabagacad'

# Grep colors.
export GREP_COLOR='37;45'           # BSD.
export GREP_COLORS="mt=$GREP_COLOR" # GNU.

# Use lesspipe if available. It allows you to use less on binary files (*.tar.gz, *.jpg, etc.).
if (( $+commands[pygmentize] )); then
    export LESSOPEN="| pygmentize -f console -O bg=dark %s"
elif (( $+commands[lesspipe] || $+commands[lesspipe.sh] )); then
    export LESSOPEN="| /usr/bin/env ${(q)${commands[lesspipe]:-${commands[lesspipe.sh]}}} %s 2>/dev/null"
fi

# This affects every invocation of `less`.
#
#   -i   case-insensitive search unless search string contains uppercase letters
#   -R   color
#   -F   exit if there is less than one page of content
#   -X   keep content on screen after exit
#   -M   show more info at the bottom prompt line
#   -x4  tabs are 4 instead of 8
export LESS='-iRFXMx4 --mouse'

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4;
