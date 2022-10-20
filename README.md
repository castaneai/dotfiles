# dotfiles

[castaneai](https://github.com/castaneai)'s dotfiles


## Setup (common)

```sh
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
git clone https://github.com/b4b4r07/enhancd ~/.enhancd
./install.sh
curl -sS https://starship.rs/install.sh | sh
```

## Setup (Ubuntu)

```sh
apt install python3-pip xbindkeys exa tig xdotool
pip3 install xkeysnail
./.xkeysnail/install.sh
```

## Setup (Arch Linux)

```sh
sudo pacman -S exa tig xdotool xorg-xhost
yay -S xkeysnail
./.xkeysnail/install.sh
```

## Setup (macOS)

```sh
brew install exa tig fzy
```
