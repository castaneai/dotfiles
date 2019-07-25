source ~/enhancd/init.sh
source ~/.git-prompt.sh
PS1='\w $(__git_ps1 "(%s)") \$ '

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


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
