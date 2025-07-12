#!/bin/bash

send_json() {
    local TEXT="${1:-}"
    local TOOLTIP="${2:-}"
    local CLASS="${3:-}"
    local PERCENTAGE="${4:-0}"

    printf '{"text": "%s", "tooltip": "%s", "class": "%s", "percentage": %s}\n' "$TEXT" "$TOOLTIP" "$CLASS" "$PERCENTAGE"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    generate_json "$@"
fi
