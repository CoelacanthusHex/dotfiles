# git 代理设置
function git-proxy(){
    git config --global http.proxy http://127.0.0.1:1081
    git config --global https.proxy https://127.0.0.1:1082
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
			(*.zip|*.war|*.jar|*.sublime-package|*.ipsw|*.xpi|*.apk|*.aar|*.whl) unzip "$1" -d $extract_dir ;;
			(*.rar) unrar x -ad "$1" ;;
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

function jit() {
  emulate -L zsh
  [[ $1.zwc -nt $1 || ! -w ${1:h} ]] && return
  zmodload -F zsh/files b:zf_mv b:zf_rm
  local tmp=$1.tmp.$$.zwc
  {
    zcompile -R -- $tmp $1 && zf_mv -f -- $tmp $1.zwc || return
  } always {
    (( $? )) && zf_rm -f -- $tmp
  }
}

function jit-source() {
  emulate -L zsh
  [[ -e $1 ]] && jit $1 && source -- $1
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

# for systemd 230+
# see https://github.com/tmux/tmux/issues/428
#if [[ $_has_re -eq 1 ]] && \
#  (( $+commands[tmux] )) && (( $+commands[systemctl] )); then
#  [[ $(systemctl --version) =~ 'systemd ([0-9]+)' ]] || true
#  if [[ $match -ge 230 ]]; then
#    tmux () {
#      if command tmux has; then
#        command tmux $@
#      else
#        systemd-run --user --scope tmux $@
#      fi
#    }
#  fi
#  unset match
#fi

# check fcitx5 dbus
function check-fcitx5-dbus() {
    qdbus org.fcitx.Fcitx5 /controller org.fcitx.Fcitx.Controller1.DebugInfo
}

# vim: ft=zsh
