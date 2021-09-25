#!/usr/bin/env bash
if [ -x /usr/local/bin/xkeysnail ]; then
    xhost +SI:localuser:root
    device=`python3 -c "import evdev; print([device.path for device in [evdev.InputDevice(path) for path in evdev.list_devices()] if 'MX Keys' in device.name][0])"`
    /usr/local/bin/xkeysnail /home/castaneai/.xkeysnail/config.py --device $device
fi
