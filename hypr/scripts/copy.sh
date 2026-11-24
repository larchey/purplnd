#!/bin/bash
# SUPER+C -> copy. Sends the focused app its own copy shortcut. Terminals use
# Ctrl+Shift+C (plain Ctrl+C would interrupt the running program).
# Uses Hyprland's sendshortcut, which replaces the held SUPER modifier, so the
# app sees exactly Ctrl+C and no extra package (wtype) is needed.

class=$(hyprctl activewindow -j 2>/dev/null | jq -r '.class // ""')

case "$class" in
    kitty|btop|Alacritty|foot|org.wezfurlong.wezterm|konsole|org.kde.konsole|xterm|XTerm)
        hyprctl dispatch sendshortcut "CTRL SHIFT, C, activewindow"
        ;;
    *)
        hyprctl dispatch sendshortcut "CTRL, C, activewindow"
        ;;
esac
