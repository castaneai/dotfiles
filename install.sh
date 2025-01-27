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

# Linux
if [[ "$(uname)" == "Linux" ]]; then
    # xremap
    mkdir -p ~/.config/xremap
    ln -nsf "${DOTFILES_DIR}/.config/xremap/xremap.yaml" ~/.config/xremap/xremap.yaml
    ${DOTFILES_DIR}/.config/xremap/install-service.sh

    # i3wm
    mkdir -p ~/.config/i3
    ln -nsf "${DOTFILES_DIR}/.config/i3/config" ~/.config/i3/config
fi

# suppress "Last login:" message
ln -nsf "${DOTFILES_DIR}/.hushlogin" ~/.hushlogin
