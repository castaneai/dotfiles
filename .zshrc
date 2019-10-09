PROMPT='%~ $ '
export GOPATH=~/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
export DOCKER_BUILDKIT=1

alias ll='ls -la'
alias ts='tig status'
alias p='ghq look $(ghq list | fzf)'
alias fig='docker-compose'
alias reload='exec $SHELL -l'
alias gc='git reset --hard HEAD && git clean -df'
alias co='git checkout $(git branch | fzy)'
[ -x "$(command -v exa)" ] && alias ls='exa'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

zplug load --verbose
