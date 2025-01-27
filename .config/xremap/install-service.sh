#!/bin/bash
set -euxo pipefail

# https://github.com/xremap/xremap?tab=readme-ov-file#running-xremap-without-sudo
sudo gpasswd -a "${USER}" input
echo 'KERNEL=="uinput", GROUP="input", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/99-input.rules
echo uinput | sudo tee /etc/modules-load.d/uinput.conf

# https://github.com/xremap/xremap/issues/188#issuecomment-1272749372
mkdir -p ~/.config/systemd/user
cat <<EOS > ~/.config/systemd/user/xremap.service
[Unit]
Description=xremap

[Service]
ExecStart=xremap ${HOME}/.config/xremap/xremap.yaml
Restart=always

[Install]
WantedBy=default.target
EOS

mkdir -p ~/.config/autostart
cat <<EOS > ~/.config/autostart/xremap.desktop
[Desktop Entry]
Name=Xremap
Type=Application
Exec=systemctl --user start xremap
Terminal=false
EOS

systemctl --user enable xremap
