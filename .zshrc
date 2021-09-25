autoload -Uz vcs_info
setopt PROMPT_SUBST
precmd () { vcs_info }
zstyle ':vcs_info:*' formats "(%b)"

PROMPT='%~ ${vcs_info_msg_0_} $ '
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'

# history 
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
setopt hist_ignore_dups

export GOPATH=~/go
export GOBIN=$GOPATH/bin
export PATH=/usr/local/bin:$PATH:$GOBIN:$HOME/bin:/usr/local/go/bin
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

alias ll='ls -la'
alias ts='tig status'
alias fig='docker-compose'
alias reload='exec $SHELL -l'
alias gc='git reset --hard HEAD && git clean -df'
alias br='git switch $(git branch | fzy)'
alias k=kubectl
[ -x "$(command -v exa)" ] && alias ls='exa'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f ~/.cargo ] && source ~/.cargo/env

[ -x "$(command -v starship)" ] && eval "$(starship init zsh)"

# 使わない割に他のコマンドと衝突して邪魔だったので無効化
export ENHANCD_DISABLE_DOT=1

source ~/.enhancd/init.sh

source ~/.zshrc.local

