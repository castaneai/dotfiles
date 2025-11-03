#!/bin/sh

[ -f /etc/xprofile ] && source /etc/xprofile
[ -f ~/.xprofile ] && source ~/.xprofile

# if using GNOME
export XDG_SESSION_TYPE=x11
export GDK_BACKEND=x11
exec gnome-session

# if using i3
# exec i3
