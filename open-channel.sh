#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title Open Teams Channel
# @raycast.mode silent
# @raycast.argument1 { "type": "text", "placeholder": "Channel URL or Name" }
# @raycast.icon 📺
# @raycast.packageName Microsoft Teams

CHANNEL="$1"
LOG_FILE=~/teams-raycast.log

if [[ -z "$CHANNEL" ]]; then
    echo "[$(date)] Error: Channel URL or name is required." >> "$LOG_FILE"
    echo "Error: Channel URL or name is required."
    exit 1
fi

TEAMS_PROCESS="Microsoft Teams"
if pgrep -x "Microsoft Teams (work or school)" > /dev/null; then
    TEAMS_PROCESS="Microsoft Teams (work or school)"
fi

if [[ "$CHANNEL" == *"teams.microsoft.com"* ]]; then
    channel_url=$(echo "$CHANNEL" | sed 's/https:/msteams:/')
    open "$channel_url" || { echo "[$(date)] Failed to open channel" >> "$LOG_FILE"; echo "Failed to open channel"; exit 1; }
    echo "[$(date)] Opened channel: $channel_url" >> "$LOG_FILE"
else
    osascript -e "
    try
        tell application \"$TEAMS_PROCESS\" to activate
        tell application \"System Events\"
            if not (exists process \"$TEAMS_PROCESS\") then
                error \"$TEAMS_PROCESS is not running\"
            end if
            tell process \"$TEAMS_PROCESS\"
                keystroke \"e\" using {command down}
                delay 1
                keystroke \"$CHANNEL\"
                delay 1
                keystroke return
            end tell
        end tell
    on error errMsg
        do shell script \"echo '[$(date)] Error opening channel: \" & quoted form of errMsg & \"' >> $LOG_FILE\"
        display notification errMsg with title \"Raycast Error\"
        return
    end try
    "
    echo "[$(date)] Searched for channel: $CHANNEL" >> "$LOG_FILE"
fi