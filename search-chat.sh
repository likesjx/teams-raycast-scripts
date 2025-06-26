#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title Search Teams Chat
# @raycast.mode silent
# @raycast.argument1 { "type": "text", "placeholder": "Person or chat name" }
# @raycast.icon 🔍
# @raycast.packageName Microsoft Teams

SEARCH_QUERY="$1"
LOG_FILE=~/teams-raycast.log

if [[ -z "$SEARCH_QUERY" ]]; then
    echo "[$(date)] Error: Search query is required." >> "$LOG_FILE"
    echo "Error: Search query is required."
    exit 1
fi

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
            keystroke \"e\" using {command down}
            delay 1
            keystroke \"$SEARCH_QUERY\"
            delay 1
            keystroke return
        end tell
    end tell
on error errMsg
    do shell script \"echo '[$(date)] Error searching chat: \" & quoted form of errMsg & \"' >> $LOG_FILE\"
    display notification errMsg with title \"Raycast Error\"
    return
end try
"
echo "[$(date)] Searched for chat: $SEARCH_QUERY" >> "$LOG_FILE"