#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title Toggle Mute
# @raycast.mode silent
# @raycast.icon 🎤
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
        set currentApp to name of first application process whose frontmost is true
        tell application \"$TEAMS_PROCESS\" to activate
        delay 0.5
        tell process \"$TEAMS_PROCESS\"
            keystroke \"m\" using {command down, shift down}
        end tell
        tell application currentApp to activate
    end tell
on error errMsg
    do shell script \"echo '[$(date)] Error toggling mute: \" & quoted form of errMsg & \"' >> $LOG_FILE\"
    display notification errMsg with title \"Raycast Error\"
    return
end try
"
echo "[$(date)] Toggled mute" >> "$LOG_FILE"