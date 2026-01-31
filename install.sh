#!/bin/bash
set -euxo pipefail

DOTFILES_DIR="$(dirname $(readlink -f $0))"
dotfiles=(.zshrc .tigrc .gitconfig .vimrc .xbindkeysrc .config/starship.toml .config/pulse/default.pa .xprofile .xinitrc .hushlogin)
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
ln -nsf "${DOTFILES_DIR}/.config/ghostty/themes" ~/.config/ghostty/themes

# fish
mkdir -p ~/.config/fish
ln -nsf "${DOTFILES_DIR}/.config/fish/config.fish" ~/.config/fish/config.fish

# mise
mkdir -p ~/.config/mise
ln -nsf "${DOTFILES_DIR}/.config/mise/config.toml" ~/.config/mise/config.toml

# Codex
mkdir -p ~/.codex
ln -nsf "${DOTFILES_DIR}/.codex/config.toml" ~/.codex/config.toml
ln -nsf "${DOTFILES_DIR}/.codex/AGENTS.md" ~/.codex/AGENTS.md

# Claude Code
mkdir -p ~/.claude
ln -nsf "${DOTFILES_DIR}/.claude/skills" ~/.claude/skills
ln -nsf "${DOTFILES_DIR}/.claude/CLAUDE.md" ~/.claude/CLAUDE.md

# Linux
if [[ "$(uname)" == "Linux" ]]; then
    # xremap
    mkdir -p ~/.config/xremap
    ln -nsf "${DOTFILES_DIR}/.config/xremap/xremap.yaml" ~/.config/xremap/xremap.yaml
    ${DOTFILES_DIR}/.config/xremap/install-service.sh

    # X11 desktop
    if command -v Xorg &>/dev/null; then
        # i3wm
        mkdir -p ~/.config/i3
        ln -nsf "${DOTFILES_DIR}/.config/i3/config" ~/.config/i3/config

        # picom
        mkdir -p ~/.config/picom
        ln -nsf "${DOTFILES_DIR}/.config/picom/picom.conf" ~/.config/picom/picom.conf

        # rofi
        mkdir -p ~/.config/rofi
        ln -nsf "${DOTFILES_DIR}/.config/rofi/config.rasi" ~/.config/rofi/config.rasi

        # polybar
        mkdir -p ~/.config/polybar
        ln -nsf "${DOTFILES_DIR}/.config/polybar/launch.sh" ~/.config/polybar/launch.sh
        ln -nsf "${DOTFILES_DIR}/.config/polybar/config.ini" ~/.config/polybar/config.ini    fi
fi
