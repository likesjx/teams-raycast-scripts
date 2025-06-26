#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title End Day Teams Cleanup
# @raycast.mode fullOutput
# @raycast.icon 🌙
# @raycast.packageName Microsoft Teams

LOG_FILE=~/teams-raycast.log
TEAMS_PROCESS="Microsoft Teams"
if pgrep -x "Microsoft Teams (work or school)" > /dev/null; then
    TEAMS_PROCESS="Microsoft Teams (work or school)"
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
            keystroke \"Away\"
            keystroke return
        end tell
    end tell
on error errMsg
    do shell script \"echo '[$(date)] Error setting presence to Away: \" & quoted form of errMsg & \"' >> $LOG_FILE\"
    display notification errMsg with title \"Raycast Error\"
    return
end try
"

echo "[$(date)] Presence set to Away" >> "$LOG_FILE"

echo "Teams end-of-day cleanup complete!"
echo "✓ Status set to Away"
echo "✓ Ready to sign off"