#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title Join Teams Meeting
# @raycast.mode silent
# @raycast.argument1 { "type": "text", "placeholder": "Teams meeting URL" }
# @raycast.icon 📹
# @raycast.packageName Microsoft Teams

MEETING_URL="$1"
LOG_FILE=~/teams-raycast.log

if [[ -z "$MEETING_URL" ]]; then
    echo "[$(date)] Error: Meeting URL is required." >> "$LOG_FILE"
    echo "Error: Meeting URL is required."
    exit 1
fi

meeting_url=$(echo "$MEETING_URL" | sed 's/https:/msteams:/')
open "$meeting_url" || { echo "[$(date)] Failed to join meeting" >> "$LOG_FILE"; echo "Failed to join meeting"; exit 1; }
echo "[$(date)] Joined meeting: $MEETING_URL" >> "$LOG_FILE"
