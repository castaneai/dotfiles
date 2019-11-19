autoload -Uz vcs_info
setopt PROMPT_SUBST
precmd () { vcs_info }
zstyle ':vcs_info:*' formats "(%b)"

PROMPT='%~ ${vcs_info_msg_0_} $ '
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'

export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "b4b4r07/enhancd", use:init.sh

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

export GOPATH=~/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN:$HOME/bin
export DOCKER_BUILDKIT=1
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
[ -x "$(command -v goenv)" ] && eval "$(goenv init -)"

alias ll='ls -la'
alias ts='tig status'
alias fig='docker-compose'
alias reload='exec $SHELL -l'
alias gc='git reset --hard HEAD && git clean -df'
alias co='git checkout $(git branch | fzy)'
[ -x "$(command -v exa)" ] && alias ls='exa'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

