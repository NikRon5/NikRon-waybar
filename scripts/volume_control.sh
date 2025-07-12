case $1 in
    down)
        VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')
        if [ $VOLUME -lt 100 ]; then
            wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+
        elif [ $VOLUME -gt 100 ]; then
            wpctl set-volume @DEFAULT_AUDIO_SINK@ 100%
        fi
    ;;
    up)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-
    ;;
    toggle)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    ;;
esac
