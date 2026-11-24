#!/bin/bash
# SUPER+V -> paste. Hyprland doesn't have a universal "paste" action (there's
# no OS-level paste, just apps reacting to their own keybind), so this just
# synthesizes the real keypress the focused app actually listens for, via
# wtype (virtual-keyboard-unstable-v1). Terminal emulators conventionally
# reserve plain Ctrl+V (vim block-visual mode, etc.) and use Ctrl+Shift+V for
# paste instead, so those get the shifted combo; everything else gets Ctrl+V.

class=$(hyprctl activewindow -j 2>/dev/null | jq -r '.class // ""')

case "$class" in
    kitty|Alacritty|foot|org.wezfurlong.wezterm|konsole|org.kde.konsole|xterm|XTerm)
        wtype -M ctrl -M shift -k v -m shift -m ctrl
        ;;
    *)
        wtype -M ctrl -k v -m ctrl
        ;;
esac
