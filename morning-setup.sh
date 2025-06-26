#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title Morning Teams Setup
# @raycast.mode fullOutput
# @raycast.icon 🌅
# @raycast.packageName Microsoft Teams

LOG_FILE=~/teams-raycast.log
TEAMS_PROCESS="Microsoft Teams"
if pgrep -x "Microsoft Teams (work or school)" > /dev/null; then
    TEAMS_PROCESS="Microsoft Teams (work or school)"
fi

echo "[$(date)] Starting Morning Teams Setup" >> "$LOG_FILE"

if ! pgrep -x "$TEAMS_PROCESS" > /dev/null; then
    open -a "$TEAMS_PROCESS" || { echo "[$(date)] Error: Failed to open Teams" >> "$LOG_FILE"; echo "Error: Failed to open Teams"; exit 1; }
    echo "[$(date)] Teams opened successfully" >> "$LOG_FILE"
    sleep 3
fi

osascript -e "
try
    tell application \"$TEAMS_PROCESS\" to activate
    delay 2
    tell application \"System Events\"
        if not (exists process \"$TEAMS_PROCESS\") then
            error \"$TEAMS_PROCESS is not running\"
        end if
        tell process \"$TEAMS_PROCESS\"
            keystroke \"t\" using {command down, shift down}
            delay 1
            keystroke \"Available\"
            keystroke return
        end tell
    end tell
on error errMsg
    do shell script \"echo '[$(date)] Error setting presence: \" & quoted form of errMsg & \"' >> $LOG_FILE\"
    display notification errMsg with title \"Raycast Error\"
    return
end try
"

echo "[$(date)] Presence set to Available" >> "$LOG_FILE"

osascript -e "
try
    tell application \"System Events\"
        tell process \"$TEAMS_PROCESS\"
            keystroke \"4\" using {command down}
            delay 1
        end tell
    end tell
on error errMsg
    do shell script \"echo '[$(date)] Error opening calendar: \" & quoted form of errMsg & \"' >> $LOG_FILE\"
    display notification errMsg with title \"Raycast Error\"
    return
end try
"

echo "[$(date)] Calendar opened" >> "$LOG_FILE"

echo "Teams morning setup complete!"
echo "✓ Teams opened"
echo "✓ Status set to Available"
echo "✓ Calendar opened"