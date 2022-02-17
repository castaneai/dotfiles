#!/bin/bash

DOTFILES_DIR="$(dirname $(readlink -f $0))"
dotfiles=(.zshrc .tigrc .gitconfig .vimrc .xbindkeyrc .config/starship.toml .config/pulse/default.pa .xkeysnail)
for f in "${dotfiles[@]}"; do
    ln -sf "${DOTFILES_DIR}/${f}" ~/${f}
done

ln -sf "${DOTFILES_DIR}/.config/Code/User/settings.json" ~/.config/Code/User/settings.json
ln -sf "${DOTFILES_DIR}/.config/Code/User/keybindings.json" ~/.config/Code/User/keybindings.json
