#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title Open Teams Files
# @raycast.mode silent
# @raycast.icon 📁
# @raycast.packageName Microsoft Teams

LOG_FILE=~/teams-raycast.log
TEAMS_PROCESS="Microsoft Teams"
if pgrep -x "Microsoft Teams (work or school)" > /dev/null; then
    TEAMS_PROCESS="Microsoft Teams (work or school)"
fi

osascript -e "
try
    tell application \"$TEAMS_PROCESS\" to activate
    tell application \"System Events\"
        if not (exists process \"$TEAMS_PROCESS\") then
            error \"$TEAMS_PROCESS is not running\"
        end if
        tell process \"$TEAMS_PROCESS\"
            keystroke \"3\" using {command down}
            delay 1
        end tell
    end tell
on error errMsg
    do shell script \"echo '[$(date)] Error opening files: \" & quoted form of errMsg & \"' >> $LOG_FILE\"
    display notification errMsg with title \"Raycast Error\"
    return
end try
"
echo "[$(date)] Opened Teams Files" >> "$LOG_FILE"