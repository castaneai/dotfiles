sudo groupadd uinput
sudo usermod -aG input,uinput $USER
echo 'KERNEL=="event*", NAME="input/%k", MODE="660", GROUP="input"' | sudo tee /etc/udev/rules.d/70-input.rules > /dev/null
echo 'KERNEL=="uinput", GROUP="uinput"' | sudo tee /etc/udev/rules.d/70-uinput.rules > /dev/null
mkdir -p ~/.config/systemd/user
ln -sf ${PWD}/xkeysnail.service ~/.config/systemd/user/xkeysnail.service
systemctl --user enable xkeysnail
systemctl --user status xkeysnail
