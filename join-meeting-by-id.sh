#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title Join Meeting by ID
# @raycast.mode silent
# @raycast.argument1 { "type": "text", "placeholder": "Meeting ID" }
# @raycast.icon 🔢
# @raycast.packageName Microsoft Teams

MEETING_ID="$1"
LOG_FILE=~/teams-raycast.log

if [[ -z "$MEETING_ID" ]]; then
    echo "[$(date)] Error: Meeting ID is required." >> "$LOG_FILE"
    echo "Error: Meeting ID is required."
    exit 1
fi

open "msteams://teams.microsoft.com/l/meetup-join/19:meeting_${MEETING_ID}" || { echo "[$(date)] Failed to join meeting" >> "$LOG_FILE"; echo "Failed to join meeting"; exit 1; }
echo "[$(date)] Joined meeting by ID: $MEETING_ID" >> "$LOG_FILE"