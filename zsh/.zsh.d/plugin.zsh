# Load Zinit if cloned.
if [[ -f "$HOME/.zinit/bin/zinit.zsh" ]]; then
    source "$HOME/.zinit/bin/zinit.zsh"
else
    function zinit () { return 1 }
    function zsh-defer () { return 1 }
    function Zinit-Install () {
        which git >/dev/null 2>&1 || { print -P "%B%F{red}!! Git was NOT FOUND :(%f%b" >&2 && return 1 }
        [[ -d "$HOME/.zinit" ]] || command mkdir -p "$HOME/.zinit"
        command git clone https://github.com/zdharma/zinit.git $HOME/.zinit/bin
        print -P "%B%F{green}=> Zinit was installed ! :) Installing plugins...%f%b"
        exec zsh
    }
    print -P "%B%F{yellow}=> Zinit is not installed. Install with \`Zinit-Install'%f%b" >&2
fi
source "$HOME/.zinit/bin/zinit.zsh"
module_path+=( "$HOME/.zinit/bin/zmodules/Src" )
zmodload zdharma/zplugin

[[ "$COLORTERM" == (24bit|truecolor) || "${terminfo[colors]}" -eq '16777216' ]] || zmodload zsh/nearcolor

# Basic LS_COLORS
[[ -n $DISPLAY || -n $ANDROID_ROOT ]] || eval "$(dircolors -b)"

# Extended LS_COLORS
zinit atclone"dircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh" nocompile'!' if'[[ -n $DISPLAY || -n $ANDROID_ROOT ]]' light-mode for trapd00r/LS_COLORS

zinit light romkatv/zsh-defer

zinit ice depth=1; zinit light romkatv/powerlevel10k

zsh-defer zinit light-mode for \
    hlissner/zsh-autopair \
    skywind3000/z.lua \
    wfxr/forgit \
    zthxxx/zsh-history-enquirer


# 加载 OMZ 框架及部分插件
# Snippets / Plugins.
zsh-defer zinit light-mode for \
    OMZP::git/git.plugin.zsh \
    OMZP::command-not-found/command-not-found.plugin.zsh \
    OMZP::colored-man-pages/colored-man-pages.plugin.zsh \
    OMZP::hitokoto/hitokoto.plugin.zsh \
    OMZP::sudo/sudo.plugin.zsh \
    OMZP::systemd/systemd.plugin.zsh \
    zsh-users/zsh-history-substring-search \
    MichaelAquilina/zsh-you-should-use \
    voronkovich/gitignore.plugin.zsh

#zsh-defer zinit light mafredri/zsh-async

zinit snippet OMZL::history.zsh
zinit snippet OMZL::key-bindings.zsh


# You should use
YSU_MESSAGE_POSITION="after"
YSU_IGNORED_ALIASES=("zi" "zin" "zini" "zpl" "zplg" "g" "vim")


# Rust
zinit as="completion" for \
    OMZP::cargo/_cargo \
    OMZP::rust/_rust \
    OMZP::fd/_fd


# Git 相关
zinit ice wait"2" lucid as"program" pick"bin/git-dsf"
zsh-defer zinit light zdharma/zsh-diff-so-fancy

zinit ice wait"2" lucid as"program" pick"git-now"
zsh-defer zinit light iwata/git-now

zinit ice wait"2" lucid as"program" pick"$ZPFX/bin/git-alias" make"PREFIX=$ZPFX" nocompile
zsh-defer zinit light tj/git-extras

zinit ice wait"2" lucid as"program" atclone'perl Makefile.PL PREFIX=$ZPFX' atpull'%atclone' \
            make'install' pick"$ZPFX/bin/git-cal"
zsh-defer zinit light k4rthik/git-cal

# fast jump
#zinit light skywind3000/z.lua
zsh-defer zinit light changyuheng/fz
export BETTER_EXCEPTIONS=1
export _ZL_MATCH_MODE=1 # z.lua 增强匹配算法
export _ZL_ADD_ONCE=1
export FZ_HISTORY_CD_CMD="_zlua"


# ==== 初始化补全 ====

#zinit light-mode for \
#    zsh-users/zsh-syntax-highlighting \
#    zsh-users/zsh-autosuggestions
zsh-defer zinit light-mode for \
   atload"zicompinit; zicdreplay" zdharma/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" zsh-users/zsh-autosuggestions
export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)
export ZSH_AUTOSUGGEST_USE_ASYNC=true

