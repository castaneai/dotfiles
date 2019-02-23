source ~/enhancd/init.sh
source ~/.git-prompt.sh
PS1='\w $(__git_ps1 "(%s)") \$ '

export GOPATH=~/go

alias ll='ls -la'
alias ts='tig status'
alias p='ghq look $(ghq list | fzf)'
alias fig='docker-compose'
alias reload='exec $SHELL -l'
[ -x "$(command -v exa)" ] && alias ls='exa'


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
