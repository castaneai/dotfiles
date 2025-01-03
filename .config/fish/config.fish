alias ll='ls -la'
alias ts='tig status'
alias fig='docker compose'
alias reload='exec fish'
alias gc='git reset --hard HEAD && git clean -df'
alias br='git switch $(git branch | fzy)'

# https://stackoverflow.com/questions/13995857/suppress-or-customize-intro-message-in-fish-shell
set -U fish_greeting ""

# https://docs.brew.sh/Manpage#shellenv-shell-
if test -d /opt/homebrew
    eval (/opt/homebrew/bin/brew shellenv)
end

# https://starship.rs/guide/#step-2-set-up-your-shell-to-use-starship
if type -q starship
    starship init fish | source
end

# https://mise.jdx.dev/getting-started.html#_2-activate-mise
if test -e ~/.local/bin/mise
    ~/.local/bin/mise activate fish | source
end

# https://github.com/fish-shell/fish-shell/issues/3011#issuecomment-512061416
bind \t accept-autosuggestion
