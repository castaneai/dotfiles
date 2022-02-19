# -*- coding: utf-8 -*-
 
import re
from xkeysnail.transform import *
 
# define timeout for multipurpose_modmap
define_timeout(1)
 
# [Global modemap] Change modifier keys as in xmodmap
define_modmap({
    Key.CAPSLOCK: Key.LEFT_CTRL
})

terminals = [term.casefold() for term in ["gnome-terminal"]]

define_conditional_modmap(lambda wm_class: wm_class.casefold() not in terminals, {
    Key.CAPSLOCK: Key.LEFT_CTRL,
    Key.LEFT_ALT: Key.LEFT_CTRL,
})

def on_gui_editor(wm_class):
    return wm_class.startswith("jetbrains-") or wm_class == "Code"

def emacs_keybind_enabled(wm_class):
    # disable on GUI editor because of vim-keybind
    if on_gui_editor(wm_class):
        return False
    return True
 
# Emacs-like keybindings in non-Emacs applications
define_keymap(emacs_keybind_enabled, {
    # Cursor
    K("C-b"): with_mark(K("left")),
    K("C-f"): with_mark(K("right")),
    K("C-p"): with_mark(K("up")),
    K("C-n"): with_mark(K("down")),
    # Beginning/End of line
    K("C-a"): with_mark(K("home")),
    K("C-e"): with_mark(K("end")),
}, "Emacs-like keys")

define_keymap(lambda wm_class: wm_class.casefold() not in terminals, {
    K("Ctrl-A"): K("Ctrl-slash"), # select-all for GNOME
}, "for GNOME settings")

define_keymap(lambda wm_class: wm_class.casefold() in terminals, {
    K("Alt-Tab"): K("Ctrl-Tab"),
}, "for terminal apps")
