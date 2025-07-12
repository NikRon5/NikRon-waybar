#!/bin/bash

pkill -f "pw-mon.*volume" 2>/dev/null || true

source ~/.config/waybar/scripts/json_tool.sh

get_volume() {
    VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')
    MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo yes || echo no)


    if [ $MUTED = "yes" ]; then
        send_json "" "Volume: $VOLUME%\nMuted" "volume-muted" "$VOLUME"
    elif [ $VOLUME -eq 0 ]; then
        send_json "" "Volume: 0%" "volume-0" 0
    elif [ $VOLUME -lt 20 ]; then
        send_json "" "Volume: $VOLUME%" "volume-low" "$VOLUME"
    elif [ $VOLUME -lt 60 ]; then
        send_json "" "Volume: $VOLUME%" "volume-medium" "$VOLUME"
    else
        send_json "" "Volume: $VOLUME%" "volume-high" "$VOLUME"
    fi

}

get_volume

while :; do
    pw-mon | grep --line-buffered "volume" | while read -r _; do
        get_volume
    done
    get_volume
done
