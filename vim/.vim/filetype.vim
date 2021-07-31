if &cp
  set nocompatible " openSUSE needs this because its /etc/vimrc calls syntax on too early
endif

augroup filetypedetect
  au BufNewFile,BufRead *.jsm				setf javascript
  au BufNewFile,BufRead *.json				setf json
  au BufRead		*/.getmail/*rc			setf getmailrc
  au BufRead		.msmtprc			setf msmtp
  au BufNewFile,BufRead .htaccess.*			setf apache
  au BufRead		pacman.log			setf pacmanlog
  au BufNewFile,BufRead *.rfc				setf rfc
  au BufNewFile,BufRead *.md				setf markdown
  au BufRead		grub.cfg			setf sh
  au BufNewFile,BufRead fcitx_skin.conf,*/fcitx*.{conf,desc}*,*/fcitx/profile	setf dosini
  au BufNewFile,BufRead mimeapps.list			setf desktop
  au BufRead		*tmux.conf			setf tmux
  au BufNewFile,BufRead	*/xorg.conf.d/*			setf xf86conf
  au BufNewFile,BufRead *openvpn*/*.conf,*.ovpn		setf openvpn
  au BufRead		$HOME/.cabal/config		setf cabal
  au BufRead		*procmaillog			setf mail
  au BufNewFile,BufRead wg*.conf,peers.conf	setf dosini
augroup END
