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

# 候補が1つのときは補完1つめで決定
zstyle ':completion:*:default' menu select=2

# オプションの説明だす
zstyle ':completion:*:options' description 'yes'

# ???
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true

# 補完に色付け
zstyle ':completion:*:default' list-colors ""

# 補完候補をグループ分けして表示
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''

# あいまい補完
zstyle ':completion:*' matcher-list 'r:[[:ascii:]]||[[:ascii:]]=** r:|=* m:{a-z\-}={A-Z\_}'

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
alias ls='ls -G'
alias ll='ls -lF'

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
