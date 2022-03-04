if &cp
    set nocompatible " openSUSE needs this because its /etc/vimrc calls syntax on too early
endif

augroup filetypedetect
    autocmd BufNewFile,BufRead   *.jsm                    setf javascript
    autocmd BufNewFile,BufRead   *.json                   setf json
    autocmd BufRead              */.getmail/*rc           setf getmailrc
    autocmd BufRead              .msmtprc                 setf msmtp
    autocmd BufNewFile,BufRead   .htaccess.*              setf apache
    autocmd BufRead              pacman.log               setf pacmanlog
    autocmd BufNewFile,BufRead   *.rfc                    setf rfc
    autocmd BufRead              grub.cfg                 setf sh
    autocmd BufNewFile,BufRead   fcitx_skin.conf,*/fcitx*.{conf,desc}*,*/fcitx/profile    setf dosini
    autocmd BufNewFile,BufRead   mimeapps.list            setf desktop
    autocmd BufRead              *tmux.conf               setf tmux
    autocmd BufNewFile,BufRead   */xorg.conf.d/*          setf xf86conf
    autocmd BufNewFile,BufRead   *openvpn*/*.conf,*.ovpn  setf openvpn
    autocmd BufRead              $HOME/.cabal/config      setf cabal
    autocmd BufRead              *procmaillog             setf mail
    autocmd BufNewFile,BufRead   wg*.conf,peers.conf      setf dosini
    autocmd BufRead,BufNewFile   *mutt-*                  setf mail
augroup END

" kate: space-indent on; indent-width 4; syntax vim;
