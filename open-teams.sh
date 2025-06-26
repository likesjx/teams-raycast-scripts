#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title Open Microsoft Teams
# @raycast.mode silent
# @raycast.icon 👥
# @raycast.packageName Microsoft Teams

LOG_FILE=~/teams-raycast.log
if ! pgrep -x "Microsoft Teams" > /dev/null && ! pgrep -x "Microsoft Teams (work or school)" > /dev/null; then
    open -a "Microsoft Teams" || { echo "[$(date)] Failed to open Microsoft Teams" >> "$LOG_FILE"; echo "Failed to open Microsoft Teams"; exit 1; }
    echo "[$(date)] Microsoft Teams opened successfully" >> "$LOG_FILE"
else
    echo "[$(date)] Microsoft Teams is already running" >> "$LOG_FILE"
    echo "Microsoft Teams is already running"
fi
