bindkey -e

# show vcs info in prompt
autoload -Uz vcs_info
setopt PROMPT_SUBST
precmd () { vcs_info }
zstyle ':vcs_info:*' formats "(%b)"
PROMPT='%~ ${vcs_info_msg_0_} $ '

# history 
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS

# env vars
export LANG=en_US.UTF-8
export GOPATH=~/go
export GOBIN=$GOPATH/bin
export EDITOR=vim
export PATH="/usr/local/bin:$PATH:$GOBIN:$HOME/bin:/usr/local/go/bin:/usr/local/node/bin:${KREW_ROOT:-$HOME/.krew}/bin"
# 使わない割に他のコマンドと衝突して邪魔だったので無効化
export ENHANCD_DISABLE_DOT=1
# https://github.com/sh0rez/kubectl-neat-diff
[ -x "$(command -v kubectl-neat-diff)" ] && export KUBECTL_EXTERNAL_DIFF=kubectl-neat-diff
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
# https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-environment-variables#dotnet_cli_ui_language
export DOTNET_CLI_UI_LANGUAGE=en

# aliases
alias ll='ls -la'
alias ts='gitui'
alias fig='docker compose'
alias reload='exec $SHELL -l'
alias gc='git reset --hard HEAD && git clean -df'
alias br='git switch $(git branch | fzy)'
function gfo() { git fetch origin $1:$1 && git branch --set-upstream-to=origin/$1 $1 }
alias k=kubectl
[ -x "$(command -v exa)" ] && alias ls='exa'
[ -x "$(command -v xdg-open)" ] && alias open=xdg-open
[ -x "$(command -v bat)" ] && alias cat='bat -P'
[ -f ~/.cargo/env ] && source ~/.cargo/env
[ -x "$(command -v colordiff)" ] && alias diff='colordiff -u'

# extensions
[ -x "$(command -v starship)" ] && eval "$(starship init zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.asdf/asdf.sh ] && source ~/.asdf/asdf.sh && fpath=(${ASDF_DIR}/completions $fpath)


# zsh completions
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
autoload -Uz +X bashcompinit && bashcompinit
autoload -Uz compinit && compinit
[ -x "$(command -v kubectl)" ] && source <(kubectl completion zsh)
[ -x "$(command -v aws_completer)" ] && complete -C '$(which aws_completer)' aws
[ -x "$(command -v k3d)" ] && source <(k3d completion zsh)
[ -f ~/.enhancd/init.sh ] && source ~/.enhancd/init.sh

# bash completions
if type brew &>/dev/null; then
    [ -x "$(command -v az)" ] && source "$(brew --prefix)/etc/bash_completion.d/az"
fi

# utils
function k8s-secret-value() {
    kubectl get secret --no-headers -o custom-columns=":metadata.name" | fzy | xargs kubectl get secret -o json | jq '.data | map_values(@base64d)'
}

# gcloud SDK
if [ -x "$(command -v gcloud)" ]; then
    local sdk_root="$(gcloud info --format='value(installation.sdk_root)')"
    export PATH="$sdk_root/bin:$PATH"
    source "$sdk_root/completion.zsh.inc"
fi


# dotnet
export PATH="$PATH:$HOME/.dotnet/tools"

# Wasmer
export WASMER_DIR="${HOME}/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"

# bun
if type bun &>/dev/null; then
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
    [ -s "${BUN_INSTALL}/_bun" ] && source "${BUN_INSTALL}/_bun"
fi

# direnv
[ -x "$(command -v direnv)" ] && eval "$(direnv hook zsh)"

# rancher desktop
[ -s "$HOME/.rd" ]  && export PATH="$HOME/.rd/bin:$PATH"

# aqua
if type aqua &>/dev/null; then
    export PATH="$(aqua root-dir)/bin:$PATH"
fi

# local zshrc
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

