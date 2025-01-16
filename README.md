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
sudo pacman -S eza tig xdotool xorg-xhost
yay -S xkeysnail
./.xkeysnail/install.sh
```

## Setup (macOS)

```sh
brew install eza tig fzy
```
