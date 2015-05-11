#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
if [[ -e "$HOME/.anyenv" ]]; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init - zsh)"
fi

# disable correct
unsetopt correct_all

# restart shell command
alias relogin='exec $SHELL -l'

export EDITOR=vim

if type "go" &>/dev/null; then
    export GOPATH=$HOME/.go
    export GOROOT=$(go env GOROOT)
    export PATH=$GOPATH/bin:$PATH
fi

if type "gomi" &>/dev/null; then
    alias rm="gomi"
fi
