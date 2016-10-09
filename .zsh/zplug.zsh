# zsh補完強化
zplug "zsh-users/zsh-completions"

# コマンド履歴を部分一致で検索できる神plugin
zplug "zsh-users/zsh-history-substring-search"
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# シンタックスハイライト
zplug "zsh-users/zsh-syntax-highlighting", nice:10
