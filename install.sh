#!/bin/bash
set -euxo pipefail

DOTFILES_DIR="$(dirname $(readlink -f $0))"
dotfiles=(.zshrc .tigrc .gitconfig .vimrc .xbindkeyrc .config/starship.toml .config/pulse/default.pa .xkeysnail)
for f in "${dotfiles[@]}"; do
    mkdir -p ~/$(dirname ${f})
    ln -nsf "${DOTFILES_DIR}/${f}" ~/${f}
done

mkdir -p ~/.config/Code/User
ln -sf "${DOTFILES_DIR}/.config/Code/User/settings.json" ~/.config/Code/User/settings.json
ln -sf "${DOTFILES_DIR}/.config/Code/User/keybindings.json" ~/.config/Code/User/keybindings.json
