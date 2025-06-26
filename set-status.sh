#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title Set Teams Status
# @raycast.mode fullOutput
# @raycast.argument1 { "type": "text", "placeholder": "Status message" }
# @raycast.icon 💬
# @raycast.packageName Microsoft Teams

STATUS="$1"
LOG_FILE=~/teams-raycast.log

if [[ -z "$STATUS" ]]; then
    echo "[$(date)] Error: Status message is required." >> "$LOG_FILE"
    echo "Error: Status message is required."
    exit 1
fi

TEAMS_PROCESS="Microsoft Teams"
if pgrep -x "Microsoft Teams (work or school)" > /dev/null; then
    TEAMS_PROCESS="Microsoft Teams (work or school)"
fi

osascript -e "
try
    tell application \"System Events\"
        if not (exists process \"$TEAMS_PROCESS\") then
            error \"$TEAMS_PROCESS is not running\"
        end if
        tell process \"$TEAMS_PROCESS\"
            set frontmost to true
            keystroke \"t\" using {command down, shift down}
            delay 1
            keystroke \"$STATUS\"
            keystroke return
        end tell
    end tell
on error errMsg
    do shell script \"echo '[$(date)] Error setting status: \" & quoted form of errMsg & \"' >> $LOG_FILE\"
    display notification errMsg with title \"Raycast Error\"
    return
end try
"

echo "[$(date)] Status set to: $STATUS" >> "$LOG_FILE"
echo "Status set to: $STATUS"