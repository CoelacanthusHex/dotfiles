*	sudo cp /usr/local/texlive/2021/texmf-var/fonts/conf/texlive-fontconfig.conf /etc/fonts/conf.d/09-
texlive.conf
*	修改 /etc/profile.d/texlive.sh
```bash
export TEXLIVEPATH=/usr/local/texlive/2021
export PATH=$TEXLIVEPATH/bin/x86_64-linux:$PATH
export MANPATH=$TEXLIVEPATH/texmf-dist/doc/man:$MANPATH
export INFOPATH=$TEXLIVEPATH/texmf-dist/doc/info:$INFOPATH
```
