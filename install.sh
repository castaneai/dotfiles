#!/bin/bash
set -euxo pipefail

DOTFILES_DIR="$(dirname $(readlink -f $0))"
dotfiles=(.zshrc .tigrc .gitconfig .vimrc .xbindkeysrc .config/starship.toml .config/pulse/default.pa .xkeysnail .xprofile)
for f in "${dotfiles[@]}"; do
    mkdir -p ~/$(dirname ${f})
    ln -nsf "${DOTFILES_DIR}/${f}" ~/${f}
done

OS_CONFIG_DIR="${HOME}/.config"
if [ "$(uname)" == "Darwin" ]; then
    OS_CONFIG_DIR="${HOME}/Library/Application Support"
fi

mkdir -p "${OS_CONFIG_DIR}/Code/User"
ln -nsf "${DOTFILES_DIR}/.config/Code/User/settings.json" "${OS_CONFIG_DIR}/Code/User/settings.json"
ln -nsf "${DOTFILES_DIR}/.config/Code/User/keybindings.json" "${OS_CONFIG_DIR}/Code/User/keybindings.json"

mkdir -p ~/.config/xfce4/terminal
ln -nsf "${DOTFILES_DIR}/.config/xfce4/terminal/accels.scm" ~/.config/xfce4/terminal/accels.scm
ln -nsf "${DOTFILES_DIR}/.config/xfce4/terminal/terminalrc" ~/.config/xfce4/terminal/terminalrc

mkdir -p "${OS_CONFIG_DIR}/k9s"
ln -nsf "${DOTFILES_DIR}/.config/k9s/plugin.yml" "${OS_CONFIG_DIR}/k9s/plugin.yml"

mkdir -p ~/.config/git
ln -nsf "${DOTFILES_DIR}/.config/git/ignore" ~/.config/git/ignore

mkdir -p ~/.config/wezterm
ln -nsf "${DOTFILES_DIR}/.config/wezterm/wezterm.lua" ~/.config/wezterm/wezterm.lua

mkdir -p ~/.config/zed
ln -nsf "${DOTFILES_DIR}/.config/zed/settings.json" ~/.config/zed/settings.json

# Ghostty
mkdir -p ~/.config/ghostty
ln -nsf "${DOTFILES_DIR}/.config/ghostty/config" ~/.config/ghostty/config

# fish
mkdir -p ~/.config/fish
ln -nsf "${DOTFILES_DIR}/.config/fish/config.fish" ~/.config/fish/config.fish

# suppress "Last login:" message
ln -nsf "${DOTFILES_DIR}/.hushlogin" ~/.hushlogin
