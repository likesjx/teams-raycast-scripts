#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title Schedule Teams Meeting
# @raycast.mode silent
# @raycast.argument1 { "type": "text", "placeholder": "Meeting title" }
# @raycast.argument2 { "type": "text", "placeholder": "Date/Time (e.g., tomorrow 2pm)" }
# @raycast.icon 📅
# @raycast.packageName Microsoft Teams

TITLE="$1"
DATETIME="$2"
LOG_FILE=~/teams-raycast.log

if [[ -z "$TITLE" ]]; then
    echo "[$(date)] Error: Meeting title is required." >> "$LOG_FILE"
    echo "Error: Meeting title is required."
    exit 1
fi

if [[ -z "$DATETIME" ]]; then
    echo "[$(date)] Error: Date/Time is required." >> "$LOG_FILE"
    echo "Error: Date/Time is required."
    exit 1
fi

if ! date -d "$DATETIME" >/dev/null 2>&1; then
    echo "[$(date)] Error: Invalid date/time format." >> "$LOG_FILE"
    echo "Error: Invalid date/time format. Use formats like 'tomorrow 2pm' or '2025-06-26 14:00'."
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
            keystroke \"4\" using {command down}
            delay 1
            keystroke \"n\" using {command down}
            delay 2
            keystroke \"$TITLE\"
            keystroke tab
            keystroke \"$DATETIME\"
        end tell
    end tell
on error errMsg
    do shell script \"echo '[$(date)] Error scheduling meeting: \" & quoted form of errMsg & \"' >> $LOG_FILE\"
    display notification errMsg with title \"Raycast Error\"
    return
end try
"

echo "[$(date)] Meeting '$TITLE' scheduled for $DATETIME" >> "$LOG_FILE"
echo "Meeting '$TITLE' scheduled for $DATETIME"