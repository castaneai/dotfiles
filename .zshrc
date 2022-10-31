bindkey -e
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
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS

export GOPATH=~/go
export GOBIN=$GOPATH/bin
export EDITOR=vim
export PATH="${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin:/usr/local/bin:$PATH:$GOBIN:$HOME/bin:/usr/local/go/bin:/usr/local/node/bin:${KREW_ROOT:-$HOME/.krew}/bin"

alias ll='ls -la'
alias ts='tig status'
alias fig='docker compose'
alias reload='exec $SHELL -l'
alias gc='git reset --hard HEAD && git clean -df'
alias br='git switch $(git branch | fzy)'
function gfo() { git fetch origin $1:$1 }
alias k=kubectl
[ -x "$(command -v exa)" ] && alias ls='exa'
[ -x "$(command -v starship)" ] && eval "$(starship init zsh)"

# 使わない割に他のコマンドと衝突して邪魔だったので無効化
export ENHANCD_DISABLE_DOT=1

autoload -Uz compinit && compinit
[ -f ~/.enhancd/init.sh ] && source ~/.enhancd/init.sh

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

[ -x "$(command -v kubectl)" ] && source <(kubectl completion zsh)
[ -x "$(command -v aws_completer)" ] && complete -C '$(which aws_completer)' aws
[ -x "$(command -v xdg-open)" ] && alias open=xdg-open
[ -x "$(command -v bat)" ] && alias cat=bat

function k8s-secret-value() {
    kubectl get secret --no-headers -o custom-columns=":metadata.name" | fzy | xargs kubectl get secret -o json | jq '.data | map_values(@base64d)'
}

# https://github.com/sh0rez/kubectl-neat-diff
export KUBECTL_EXTERNAL_DIFF=kubectl-neat-diff
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-environment-variables#dotnet_cli_ui_language
export DOTNET_CLI_UI_LANGUAGE=en

[ -x "$(command -v gcloud)" ] && source "$(gcloud info --format='value(installation.sdk_root)')/completion.zsh.inc"

[ -f ~/.asdf/asdf.sh ] && source ~/.asdf/asdf.sh
