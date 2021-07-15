# Load Zinit if cloned.
if [[ -f "$HOME/.zinit/bin/zinit.zsh" ]]; then
    source "$HOME/.zinit/bin/zinit.zsh"
else
    function zinit () { return 1 }
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

#if [[ -n "$__use_p10k" ]]; then
#    zinit ice depth=1; zinit light romkatv/powerlevel10k
#fi

zinit light-mode for \
    hlissner/zsh-autopair \
    ajeetdsouza/zoxide \
    wfxr/forgit \
    zthxxx/zsh-history-enquirer


# 加载 OMZ 框架及部分插件
# Snippets / Plugins.
zinit light-mode for \
    OMZP::git/git.plugin.zsh \
    OMZP::command-not-found/command-not-found.plugin.zsh \
    OMZP::colored-man-pages/colored-man-pages.plugin.zsh \
    OMZP::hitokoto/hitokoto.plugin.zsh \
    OMZP::sudo/sudo.plugin.zsh \
    OMZP::systemd/systemd.plugin.zsh \
    zsh-users/zsh-history-substring-search \
    MichaelAquilina/zsh-you-should-use \
    voronkovich/gitignore.plugin.zsh

#zinit light mafredri/zsh-async

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
zinit light zdharma/zsh-diff-so-fancy

zinit ice wait"2" lucid as"program" pick"$ZPFX/bin/git-alias" make"PREFIX=$ZPFX" nocompile
zinit light tj/git-extras

# fast jump
#zinit light skywind3000/z.lua
# TODO: disable for no zoxide support Ref: https://github.com/changyuheng/fz/issues/24
#zinit light changyuheng/fz
#export _ZL_MATCH_MODE=1 # z.lua 增强匹配算法
#export _ZL_ADD_ONCE=1
#export FZ_HISTORY_CD_CMD="_zlua"


# ==== 初始化补全 ====

#zinit light-mode for \
#    zsh-users/zsh-syntax-highlighting \
#    zsh-users/zsh-autosuggestions
zinit light-mode for \
    atload"zicompinit; zicdreplay" zdharma/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" zsh-users/zsh-autosuggestions
export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)
export ZSH_AUTOSUGGEST_USE_ASYNC=true
# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}
pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
# https://github.com/zsh-users/zsh-autosuggestions/issues/351
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste accept-line)

_ZSH_PLUGINS="/usr/share/zsh/plugins"
_enabled_plugins=(
    zsh-autosuggestions
    zsh-history-substring-search
    zsh-syntax-highlighting
)
for _zsh_plugin in $_enabled_plugins[@]; do
   [[ ! -r "$_ZSH_PLUGINS/$_zsh_plugin/$_zsh_plugin.zsh" ]] || source $_ZSH_PLUGINS/$_zsh_plugin/$_zsh_plugin.zsh
done

