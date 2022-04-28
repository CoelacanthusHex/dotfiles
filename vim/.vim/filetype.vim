vim9script

if &cp
    set nocompatible # openSUSE needs this because its /etc/vimrc calls syntax on too early
endif

augroup filetypedetect
    autocmd BufNewFile,BufRead   *.jsm                    setfiletype javascript
    autocmd BufNewFile,BufRead   *.json                   setfiletype json
    autocmd BufRead              */.getmail/*rc           setfiletype getmailrc
    autocmd BufRead              .msmtprc                 setfiletype msmtp
    autocmd BufNewFile,BufRead   .htaccess.*              setfiletype apache
    autocmd BufRead              pacman.log               setfiletype pacmanlog
    autocmd BufNewFile,BufRead   *.rfc                    setfiletype rfc
    autocmd BufRead              grub.cfg                 setfiletype sh
    autocmd BufNewFile,BufRead   fcitx_skin.conf,*/fcitx*.{conf,desc}*,*/fcitx/profile    setfiletype dosini
    autocmd BufNewFile,BufRead   mimeapps.list            setfiletype desktop
    autocmd BufRead              *tmux.conf               setfiletype tmux
    autocmd BufNewFile,BufRead   */xorg.conf.d/*          setfiletype xf86conf
    autocmd BufNewFile,BufRead   *openvpn*/*.conf,*.ovpn  setfiletype openvpn
    autocmd BufRead              $HOME/.cabal/config      setfiletype cabal
    autocmd BufRead              *procmaillog             setfiletype mail
    autocmd BufNewFile,BufRead   wg*.conf,peers.conf      setfiletype dosini
    autocmd BufRead,BufNewFile   *mutt-*                  setfiletype mail
    autocmd BufRead,BufNewFile   bird.conf,*/bird/*.conf,*/bird/*/*.conf            setfiletype bird
augroup END

# kate: space-indent on; indent-width 4; syntax vim;
