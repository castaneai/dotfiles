# -*- coding: utf-8 -*-
 
import re
from xkeysnail.transform import *
 
# define timeout for multipurpose_modmap
define_timeout(1)
 
# [Global modemap] Change modifier keys as in xmodmap
define_modmap({
    Key.CAPSLOCK: Key.LEFT_CTRL
})

 
# Emacs-like keybindings in non-Emacs applications
define_keymap(lambda wm_class: wm_class not in ("Emacs", "URxvt"), {
    # Cursor
    K("C-b"): with_mark(K("left")),
    K("C-f"): with_mark(K("right")),
    K("C-p"): with_mark(K("up")),
    K("C-n"): with_mark(K("down")),
    # Beginning/End of line
    K("C-a"): with_mark(K("home")),
    K("C-e"): with_mark(K("end")),
}, "Emacs-like keys")
 
terminals = [term.casefold() for term in ["gnome-terminal"]]

define_keymap(lambda wm_class: wm_class.casefold() not in terminals, {
    K("Alt-C"): K("Ctrl-C"), # copy
    K("Alt-X"): K("Ctrl-X"), # cut
    K("Alt-V"): K("Ctrl-V"), # paste
    K("Alt-F"): K("Ctrl-F"), # find
    K("Alt-W"): K("Ctrl-W"), # close tab
    K("Alt-A"): K("Ctrl-slash"), # select-all for GNOME
    K("Alt-Enter"): K("Ctrl-Enter"), # send
    K("Alt-Z"): K("Ctrl-Z"), # undo
    K("Alt-S"): K("Ctrl-S"), # save
})

