# git 代理设置
function git-proxy(){
    git config --global http.proxy socks5://127.0.0.1:1089
    git config --global https.proxy socks5://127.0.0.1:1089
}
function git-noproxy(){
    git config --global --unset http.proxy
    git config --global --unset https.proxy
}

# zsh_stats from oh-my-zsh https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/functions.zsh
function zsh_stats() {
  fc -l 1 | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n20
}

function compresspdf(){
    gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -sOutputFile=$2 $1
}


function man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;37m") \
		LESS_TERMCAP_md=$(printf "\e[1;37m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;47;30m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[0;36m") \
			man "$@"
}

function wifi(){
    [ -z "$1" -o -z "$2" -o -z "$3" ] && echo -e "usage: wifi <interface> <ssid> <password>: connect to <ssid> at <interface> using <password>" && return 1
    sudo bash -c "wpa_passphrase $2 $3 | wpa_supplicant -Dwext -i$1 -c/dev/stdin &"
    sleep 5
    sudo dhcpcd $1
}

if (( $+commands[nali] )); then
    function nali-mtr() {
        mtr $@ | nali
    }
    function nali-kdig() {
        kdig $@ | nali
    }
fi

# 图像压缩
function opt_png(){
	fd '.*\.png' $2 | parallel --bar optipng $1 {}
}

function opt_jpg(){
	fd '.*\.jpg' $1 | parallel --bar jpegoptim {}
}

function png2webp() {
    fd '.*\.png' $1 --exec cwebp -lossless {} -o {.}.webp ;
}

function jpg2webp() {
    fd '.*\.jpg' $1 --exec cwebp {} -o {.}.webp ;
}

function encode64() {
    if [[ $# -eq 0 ]]; then
        cat | base64
    else
        printf '%s' $1 | base64
    fi
}

function decode64() {
    if [[ $# -eq 0 ]]; then
        cat | base64 --decode
    else
        printf '%s' $1 | base64 --decode
    fi
}

alias e64=encode64
alias d64=decode64

function lib_dep() {
    ldd $1  | awk '{print $3}' | xargs pacman -Qo
}

function clip2ydcv() {
	data="$(xsel)"
	ydcv "$data"
}

function regex_ipv6() {
    grep -Eo \([[:alnum:]]{2}:\){5}[[:alnum:]]{2} $@
}

# https://github.com/lilydjwg/dotzsh/blob/master/zshrc#L508-520
rmempty () { #删除空文件 {{{2
  for i; do
    [[ -f $i && ! -s $i ]] && rm $i
  done
  return 0
}
breakln () { #断掉软链接 {{{2
  for f in $*; do
    tgt=$(readlink "$f")
    unlink "$f"
    cp -rL "$tgt" "$f"
  done
}

extract() {
	local remove_archive
	local success
	local extract_dir

	if (( $# == 0 )); then
		cat <<-'EOF' >&2
			Usage: extract [-option] [file ...]

			Options:
			    -r, --remove    Remove archive after unpacking.
		EOF
	fi

	remove_archive=1
	if [[ "$1" == "-r" ]] || [[ "$1" == "--remove" ]]; then
		remove_archive=0
		shift
	fi

	while (( $# > 0 )); do
		if [[ ! -f "$1" ]]; then
			echo "extract: '$1' is not a valid file" >&2
			shift
			continue
		fi

		success=0
		extract_dir="${1:t:r}"
		case "${1:l}" in
			(*.tar.gz|*.tgz) (( $+commands[pigz] )) && { pigz -dc "$1" | tar xv } || tar zxvf "$1" ;;
			(*.tar.bz2|*.tbz|*.tbz2) tar xvjf "$1" ;;
			(*.tar.xz|*.txz)
				tar --xz --help &> /dev/null \
				&& tar --xz -xvf "$1" \
				|| xzcat "$1" | tar xvf - ;;
			(*.tar.zma|*.tlz)
				tar --lzma --help &> /dev/null \
				&& tar --lzma -xvf "$1" \
				|| lzcat "$1" | tar xvf - ;;
			(*.tar.zst|*.tzst)
				tar --zstd --help &> /dev/null \
				&& tar --zstd -xvf "$1" \
				|| zstdcat "$1" | tar xvf - ;;
			(*.tar) tar xvf "$1" ;;
			(*.tar.lz) (( $+commands[lzip] )) && tar xvf "$1" ;;
			(*.tar.lz4) lz4 -c -d "$1" | tar xvf - ;;
			(*.tar.lrz) (( $+commands[lrzuntar] )) && lrzuntar "$1" ;;
			(*.gz) (( $+commands[pigz] )) && pigz -dk "$1" || gunzip -k "$1" ;;
			(*.bz2) bunzip2 "$1" ;;
			(*.xz) unxz "$1" ;;
			(*.lrz) (( $+commands[lrunzip] )) && lrunzip "$1" ;;
			(*.lz4) lz4 -d "$1" ;;
			(*.lzma) unlzma "$1" ;;
			(*.z) uncompress "$1" ;;
			(*.zip|*.war|*.jar|*.sublime-package|*.ipsw|*.xpi|*.apk|*.aar|*.whl|*.cbz|*.epub) unzip "$1" -d $extract_dir ;;
			(*.rar|*.cbr) unrar x -ad "$1" ;;
			(*.rpm) mkdir "$extract_dir" && cd "$extract_dir" && rpm2cpio "../$1" | cpio --quiet -id && cd .. ;;
			(*.7z) 7za x "$1" ;;
			(*.deb)
				mkdir -p "$extract_dir/control"
				mkdir -p "$extract_dir/data"
				cd "$extract_dir"; ar vx "../${1}" > /dev/null
				cd control; tar xzvf ../control.tar.gz
				cd ../data; extract ../data.tar.*
				cd ..; rm *.tar.* debian-binary
				cd ..
			;;
			(*.zst) unzstd "$1" ;;
            (*.exe) cabextract "$1" ;;
            (*.cpio) cpio -id < "$1" ;;
            (*.cba|*.ace) unace x "$1" ;;
            (*.zpaq) zpaq x "$1" ;;
            (*.arc) arc e "$1" ;;
			(*)
				echo "extract: '$1' cannot be extracted" >&2
				success=1
			;;
		esac

		(( success = $success > 0 ? $success : $? ))
		(( $success == 0 )) && (( $remove_archive == 0 )) && rm "$1"
		shift
	done
}

alias x=extract

get-git-code-line() {
	local fileext_set
	local success
	local generic_fileext_set
	generic_fileext_set='(\.yaml)|(\.md)|(\.json)|(\.toml)|(\.adoc)|(\.rst)'
	success=1
	case "$1" in
		(js|ts) fileext_set='(\.js)|(\.jsx)|(\.ts)|(\.tsx)|(\.css)|(\.html)' ;;
		(c) fileext_set='(\.c)|(\.h)' ;;
		(cpp|cxx) fileext_set='(\.cpp)|(\.cxx)|(\.h)|(\.hpp)' ;;
		(rust|rs) fileext_set='(\.rs)' ;;
		(*)
			echo "get-git-code-line: language '$1' is not supported" >&2
			success=0
		;;
	esac

	if (( $success == 1 )); then
		for file in $(git ls-files | grep -P "$generic_fileext_set|$fileext_set"); do git blame --line-porcelain $file | sed -n 's/^author //p'; done | sort | uniq -c | sort -rn;
	fi
}

get-git-code-line-mail() {
	local fileext_set
	local success
	local generic_fileext_set
	generic_fileext_set='(\.yaml)|(\.md)|(\.json)|(\.toml)|(\.adoc)|(\.rst)'
	success=1
	case "$1" in
		(js|ts) fileext_set='(\.js)|(\.jsx)|(\.ts)|(\.tsx)|(\.css)|(\.html)' ;;
		(c) fileext_set='(\.c)|(\.h)' ;;
		(cpp|cxx) fileext_set='(\.cpp)|(\.cxx)|(\.h)|(\.hpp)' ;;
		(rust|rs) fileext_set='(\.rs)' ;;
		(*)
			echo "get-git-code-line: language '$1' is not supported" >&2
			success=0
		;;
	esac

	if (( $success == 1 )); then
		for file in $(git ls-files | grep -P "$generic_fileext_set|$fileext_set"); do git blame --line-porcelain $file | sed -rn 's/^author-mail <(.*)>$/\1/p'; done | sort | uniq -c | sort -rn;
	fi
}

# https://maiyang.me/post/2020-08-18-git-commit-history-stat-hour/
get-someone-commit-time() {
	git log --author="$1" --date=iso | perl -nalE 'if (/^Date:\s+[\d-]{10}\s(\d{2})/) { say $1+0 }' | sort | uniq -c|perl -MList::Util=max -nalE '$h{$F[1]} = $F[0]; }{ $m = max values %h; foreach (0..23) { $h{$_} = 0 if not exists $h{$_} } foreach (sort {$a <=> $b } keys %h) { say sprintf "%02d - %4d %s", $_, $h{$_}, "*"x ($h{$_} / $m * 50); }'
}

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

bindkey '^Z' foreground-last-job
bindkey -M emacs '^Z' foreground-last-job
bindkey -M viins '^Z' foreground-last-job

# add a command line to the shells history without executing it
commit-to-history () {
        print -s ${(z)BUFFER}
        zle send-break
}
zle -N commit-to-history
# bindkey -M viins "^x^h" commit-to-history
# bindkey -M emacs "^x^h" commit-to-history

# https://github.com/lilydjwg/dotzsh/blob/master/zshrc#L368-382
# take screenshot to stdout (PNG)
if (( $+commands[maim] )); then
  _screenshot="maim -s -l -c 255,0,255,0.15 -k -n 2"
elif (( $+commands[import] )); then
  _screenshot="import png:-"
fi
if (( $+_screenshot )); then
  screenshot () {
    if [[ -t 1 && $# -eq 0 ]]; then
      echo >&2 "Refused to write image to terminal."
      return 1
    fi
    ${=_screenshot} "$@"
  }
fi
function clip2qr() {
	data="$(xsel)"
	echo $data
	echo $data | qrencode -t UTF8
}
screen2clip () { # 截图到剪贴板 {{{2
  screenshot | xclip -i -selection clipboard -t image/png
}
clip_bmp2png () { # 将剪贴板中的图片从 bmp 转到 png。QQ 会使用 bmp
  xclip -selection clipboard -o -t image/bmp | convert - png:- | xclip -i -selection clipboard -t image/png
}
clip_png2bmp () { # 将剪贴板中的图片从 png 转到 bmp。QQ 会使用 bmp
  xclip -selection clipboard -o -t image/png | convert - bmp:- | xclip -i -selection clipboard -t image/bmp
}

# https://github.com/lilydjwg/dotzsh/blob/313050449529c84914293283691da1e824d779f5/zshrc#L385
# for systemd 230+
# see https://github.com/tmux/tmux/issues/428
if [[ $_has_re -eq 1 ]] && \
  (( $+commands[tmux] )) && (( $+commands[systemctl] )); then
  [[ $(systemctl --version) =~ 'systemd ([0-9]+)' ]] || true
  if [[ $match -ge 230 ]]; then
    tmux () {
      if command tmux has; then
        command tmux $@
      else
        systemd-run --user --scope tmux $@
      fi
    }
  fi
  unset match
fi

# check fcitx5 dbus
function check-fcitx5-dbus() {
    qdbus org.fcitx.Fcitx5 /controller org.fcitx.Fcitx.Controller1.DebugInfo
}

# GitHub
# https://matklad.github.io/2018/05/03/effective-pull-requests.html
# calling `get-fork rust-lang/cargo` would clone github.com/matklad/cargo,
# and setup upstream properly
function get-fork() {
    local userrepo=$1
    local repo=`basename $userrepo`
    git clone git@github.com:matklad/$repo.git
    pushd $repo
    git remote add upstream git@github.com:$userrepo.git
    git fetch upstream
    git checkout master
    #git branch --set-upstream-to=upstream/master
    #git pull --rebase --force
    popd
}
# calling `set-upstream rust-lang/cargo` would setup upstream properly
function set-upstream() {
    local userrepo=$1
    git remote add upstream git@github.com:$userrepo.git
    git fetch upstream
    git checkout master
    git branch --set-upstream-to=upstream/master
}
# called like `get-pr 9262`, this function would checkout
# GitHub pull request #9262 to `pr-9262` branch
function get-pr() {
    local pr=$1
    git fetch upstream pull/$pr/head:pr-$pr
    git checkout pr-$pr
}

# https://github.com/lilydjwg/dotzsh/blob/313050449529c84914293283691da1e824d779f5/zshrc#L445
compdef mpv=mpv
mpv() {
  if [[ -z $WAYLAND_DISPLAY && -n $DISPLAY ]]; then
    # or too big
    command mpv --no-hidpi-window-scale "$@"
  else
    # or blurry
    command mpv "$@"
  fi
}

# https://github.com/lilydjwg/dotzsh/blob/313050449529c84914293283691da1e824d779f5/zshrc#L519
# 将以 %HH 表示的文件名改正常
mvpc() {
  mv -- $1 "$(echo $1|ascii2uni -a J|tr '/' '-')"
}
nocolor() {
  sed -r 's:\x1b\[[0-9;]*[mK]::g;s:[\r\x0f]::g'
}

weather() {
    # m : metric (SI) (used by default everywhere except US)
    # M : show wind speed in m/s
    # 2 : current weather + today's + tomorrow's forecast
    # A : ignore User-Agent and force ANSI output format (terminal)
    # F : do not show the "Follow" line
    # T : disable color
    local WTTR_PARAMS=('m' 'M' '2' 'F' 'n')
    if [[ -t 1 ]] && [[ "$(tput cols)" -lt 125 ]]; then
        WTTR_PARAMS+='n'
    fi 2> /dev/null
    if (( $# > 1 )); then
        lang=$2
    else
        lang=zh
    fi
    if [[ $TERM == linux ]]; then
        lang=en
        WTTR_PARAMS+='A'
        WTTR_PARAMS+='T'
    fi
    if [[ ${1:+x} == x ]]; then
        local location="${1// /+}"
    fi

    curl -fGsS --compressed $args "https://wttr.in/${location:-Feicheng}?${(j::)WTTR_PARAMS}&lang=${lang:-${LANG%_*}}"
}

# vim: ft=zsh
