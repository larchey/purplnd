#!/bin/bash
# Show an on-screen volume/brightness bar: osd.sh volume|brightness
# Only displays the current value; the keybinds do the changing. Drawn by mako
# (styled by the [app-name=osd] section of ~/.config/mako/config). The
# synchronous tag makes repeats update one popup instead of stacking.

case "$1" in
    volume)
        # "Volume: 0.80" or "Volume: 0.80 [MUTED]"
        out=$(wpctl get-volume @DEFAULT_AUDIO_SINK@) || exit 1
        val=$(awk '{printf "%d", $2 * 100 + 0.5}' <<<"$out")
        text="$val%"
        if [[ $out == *MUTED* ]]; then icon=$'\U000F075F'; text="Muted"; bar=0
        elif (( val == 0 ));  then icon=$'\U000F057F'
        elif (( val < 34 ));  then icon=$'\U000F057F'
        elif (( val < 67 ));  then icon=$'\U000F0580'
        else                       icon=$'\U000F057E'
        fi
        ;;
    brightness)
        val=$(brightnessctl -m | cut -d, -f4 | tr -d '%') || exit 1
        icon=$'\U000F00DF'; text="$val%"
        ;;
    *) echo "usage: $0 volume|brightness" >&2; exit 2 ;;
esac

bar=${bar:-$val}
(( bar > 100 )) && bar=100
exec notify-send -a osd -u normal -t 1500 \
    -h "int:value:$bar" -h "string:x-canonical-private-synchronous:osd" \
    "$icon  $text"
