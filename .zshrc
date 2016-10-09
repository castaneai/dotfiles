if [[ -f ~/.zplug/init.zsh ]]; then
    # zplug読み込み
    source ~/.zplug/init.zsh

    source ~/.zsh/zplug.zsh

    # zplugのインストールチェック
    if ! zplug check --verbose; then
        printf "Install? [y/N]: "
        if read -q; then
            echo; zplug install
        fi
    fi

    # zplug適用
    zplug load
fi

# 補完で大文字小文字区別しない
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# 履歴を残す
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history

alias la='ls -la'
alias se=sudoedit
alias reload='source ~/.zshrc'
alias vi=nvim
alias vim=nvim
alias sc='sudo systemctl'

export EDITOR=nvim
export SUDO_EDITOR=nvim
