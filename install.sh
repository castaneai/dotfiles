#!/bin/bash
set -euxo pipefail

DOTFILES_DIR="$(dirname $(readlink -f $0))"
dotfiles=(.zshrc .tigrc .gitconfig .vimrc .xbindkeysrc .config/starship.toml .config/pulse/default.pa .xkeysnail .xprofile)
for f in "${dotfiles[@]}"; do
    mkdir -p ~/$(dirname ${f})
    ln -nsf "${DOTFILES_DIR}/${f}" ~/${f}
done

mkdir -p ~/.config/Code/User
ln -nsf "${DOTFILES_DIR}/.config/Code/User/settings.json" ~/.config/Code/User/settings.json
ln -nsf "${DOTFILES_DIR}/.config/Code/User/keybindings.json" ~/.config/Code/User/keybindings.json

mkdir -p ~/.config/xfce4/terminal
ln -nsf "${DOTFILES_DIR}/.config/xfce4/terminal/accels.scm" ~/.config/xfce4/terminal/accels.scm
ln -nsf "${DOTFILES_DIR}/.config/xfce4/terminal/terminalrc" ~/.config/xfce4/terminal/terminalrc
