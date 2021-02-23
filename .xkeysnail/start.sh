#!/usr/bin/env bash
if [ -x /usr/local/bin/xkeysnail ]; then
    xhost +SI:localuser:xkeysnail
    device=`sudo -u xkeysnail python3 -c "import evdev; print([device.path for device in [evdev.InputDevice(path) for path in evdev.list_devices()] if 'Logitech Wireless' in device.name][0])"`
    sudo -u xkeysnail DISPLAY=$DISPLAY /usr/local/bin/xkeysnail -q $HOME/.xkeysnail/config.py --device $device &
fi

