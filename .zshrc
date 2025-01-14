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
export USE_GKE_GCLOUD_AUTH_PLUGIN=True
# https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-environment-variables#dotnet_cli_ui_language
export DOTNET_CLI_UI_LANGUAGE=en

# aliases
alias ll='ls -la'
alias ts='tig status'
alias fig='docker compose'
alias reload='exec $SHELL -l'
alias gc='git reset --hard HEAD && git clean -df'
alias br="git branch --list | cut -c 3- | fzy | xargs git switch"
function gfo() { git fetch origin $1:$1 && git branch --set-upstream-to=origin/$1 $1 }
alias k=kubectl
[ -x "$(command -v eza)" ] && alias ls='eza'
[ -x "$(command -v xdg-open)" ] && alias open=xdg-open
[ -x "$(command -v bat)" ] && alias cat='bat -P'
[ -f ~/.cargo/env ] && source ~/.cargo/env
[ -x "$(command -v colordiff)" ] && alias diff='colordiff -u'

# extensions
[ -x "$(command -v starship)" ] && eval "$(starship init zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zsh completions
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
autoload -Uz +X bashcompinit && bashcompinit
autoload -Uz compinit && compinit
[ -x "$(command -v kubectl)" ] && source <(kubectl completion zsh)
[ -x "$(command -v aws_completer)" ] && complete -C '$(which aws_completer)' aws
[ -x "$(command -v k3d)" ] && source <(k3d completion zsh)
[ -f ~/.enhancd/init.sh ] && source ~/.enhancd/init.sh

# utils
function k8s-secret-value() {
    kubectl get secret --no-headers -o custom-columns=":metadata.name" | fzy | xargs kubectl get secret -o json | jq '.data | map_values(@base64d)'
}

# dotnet
export PATH="$PATH:$HOME/.dotnet/tools"

# deno
export DENO_INSTALL="$HOME/.deno"
[ -s "${DENO_INSTALL}" ] && export PATH="$DENO_INSTALL/bin:$PATH"
[ -f "${DENO_INSTALL}/env" ] && . "${DENO_INSTALL}/env"

# aqua
if type aqua &>/dev/null; then
    export PATH="$(aqua root-dir)/bin:$PATH"
    export AQUA_GLOBAL_CONFIG="$(aqua root-dir)/aqua.yaml"
fi

# local zshrc
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
