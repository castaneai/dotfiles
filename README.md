# dotfiles

[castaneai](https://github.com/castaneai)'s dotfiles


## Setup (common)

```sh
# Install starship
curl -sS https://starship.rs/install.sh | sh

# Install enhancd
git clone https://github.com/b4b4r07/enhancd ~/.enhancd

# Install fzf (incremental history search via Ctrl-R)
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

## Setup (Arch Linux)

```sh
sudo pacman -S eza tig

# Desktop environment
sudo pacman -S xorg xorg-xinit i3-wm ghostty rofi feh picom xclip xbindkeys xdotool
sudo localectl set-x11-keymap jp
paru -S xremap-x11-bin
git clone https://github.com/jluttine/rofi-power-menu ~/.rofi-power-menu
mkdir -p ~/bin && cp ~/.rofi-power-menu/rofi-power-menu ~/bin/
```

## Setup (macOS)

```sh
brew install eza tig fzy
```
