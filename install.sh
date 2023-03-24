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

mkdir -p ~/.config/gitui
ln -nsf "${DOTFILES_DIR}/.config/gitui/key_bindings.ron" ~/.config/gitui/key_bindings.ron


OS_CONFIG_DIR="${HOME}/.config"
if [ "$(uname)" == "Darwin" ]; then
    OS_CONFIG_DIR="${HOME}/Library/Application Support"
fi
mkdir -p "${OS_CONFIG_DIR}/k9s"
ln -nsf "${DOTFILES_DIR}/.config/k9s/plugin.yml" "${OS_CONFIG_DIR}/k9s/plugin.yml"

