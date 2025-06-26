#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title Show Today's Meetings
# @raycast.mode fullOutput
# @raycast.icon 📅
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
        tell process \"$TEAMS_PROCESS\"
            set frontmost to true
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

echo "[$(date)] Opened Teams Calendar - Today's View" >> "$LOG_FILE"
echo "Opened Teams Calendar - Today's View"