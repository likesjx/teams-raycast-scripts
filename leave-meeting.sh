#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title Leave Meeting
# @raycast.mode silent
# @raycast.icon 🚪
# @raycast.packageName Microsoft Teams

LOG_FILE=~/teams-raycast.log
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
        tell application \"$TEAMS_PROCESS\" to activate
        delay 0.5
        tell process \"$TEAMS_PROCESS\"
            keystroke \"b\" using {command down, shift down}
        end tell
    end tell
on error errMsg
    do shell script \"echo '[$(date)] Error leaving meeting: \" & quoted form of errMsg & \"' >> $LOG_FILE\"
    display notification errMsg with title \"Raycast Error\"
    return
end try
"
echo "[$(date)] Left meeting" >> "$LOG_FILE"
