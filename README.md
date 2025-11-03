# dotfiles

[castaneai](https://github.com/castaneai)'s dotfiles


## Setup (common)

```sh
# Install starship
curl -sS https://starship.rs/install.sh | sh

# Install fzf (incremental history search via Ctrl-R)
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

## Setup (Arch Linux)

```sh
# Common shell tools
sudo pacman -S eza tig zoxide

# Desktop environment (common)
sudo pacman -S xorg xorg-xinit xclip xbindkeys xdotool
sudo localectl set-x11-keymap jp
paru -S xremap-x11-bin

# Desktop environment (GNOME)
sudo pacman -S gnome

# Desktop environment (i3)
sudo pacman -S i3-wm rofi feh picom
git clone https://github.com/jluttine/rofi-power-menu ~/.rofi-power-menu
mkdir -p ~/bin && cp ~/.rofi-power-menu/rofi-power-menu ~/bin/
```

## Setup (macOS)

```sh
brew install eza tig fzy zoxide
```
