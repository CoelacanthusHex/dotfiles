alias xdg-open='termux-open'
alias pbcopy='termux-clipboard-set'
alias pbpaste='termux-clipboard-get'

(( $+commands[okc-ssh-agent] )) && eval $(okc-ssh-agent) &> /dev/null

# vim: ft=zsh sw=4 ts=8 sts=4 et:
# kate: space-indent on; indent-width 4; syntax zsh;
