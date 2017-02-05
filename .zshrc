# zplug準備
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# cdを便利に
zplug "b4b4r07/enhancd", use:init.sh
ENHANCD_FILTER="fzy:fzf:peco"

# fuzzy-finder
zplug "jhawthorn/fzy", \
    as:command, \
    rename-to:fzy, \
    hook-build:"make && sudo make install"

# 非同期実行
zplug "mafredri/zsh-async"

# pure
zplug "sindresorhus/pure"
PURE_PROMPT_SYMBOL="✨ 👉 "
PURE_GIT_UNTRACKED_DIRTY=0

# コマンド履歴の部分一致検索
zplug "zsh-users/zsh-history-substring-search"
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=magenta,fg=white,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'
HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i'

# シンタックスハイライト
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# --- 補完系（かなしややこしい）
zstyle ':completion:*:default' menu select=2

zstyle ':completion:*' list-separator '-->'

zstyle ':completion:*:cd:*' ignore-parents parent pwd

# 補完候補をとってくる元を色々追加
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history

# 補完を色付け
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# 大小文字区別しない
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# 履歴
HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history

# Ctrl-s でなんか起こるのを防ぐ
setopt no_flow_control

# cd をいれなくてもディレクトリ名であれば自動的にcd
setopt auto_cd

# zsh構築用
alias reload='exec $SHELL -l'

# 言語
export LANG=ja_JP.UTF-8

# とりあえずalias
alias ll='ls -lF'

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
