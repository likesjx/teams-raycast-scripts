#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title Send Quick Message
# @raycast.mode fullOutput
# @raycast.argument1 { "type": "text", "placeholder": "Recipient name" }
# @raycast.argument2 { "type": "text", "placeholder": "Message" }
# @raycast.icon 💬
# @raycast.packageName Microsoft Teams

RECIPIENT="$1"
MESSAGE="$2"
LOG_FILE=~/teams-raycast.log

if [[ -z "$RECIPIENT" || -z "$MESSAGE" ]]; then
    echo "[$(date)] Error: Recipient and message are required." >> "$LOG_FILE"
    echo "Error: Recipient and message are required."
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
            keystroke \"n\" using {command down}
            delay 1
            keystroke \"$RECIPIENT\"
            delay 1
            keystroke tab
            keystroke tab
            keystroke \"$MESSAGE\"
            keystroke return
        end tell
    end tell
on error errMsg
    do shell script \"echo '[$(date)] Error sending message: \" & quoted form of errMsg & \"' >> $LOG_FILE\"
    display notification errMsg with title \"Raycast Error\"
    return
end try
"

echo "[$(date)] Message sent to $RECIPIENT: $MESSAGE" >> "$LOG_FILE"
echo "Message sent to $RECIPIENT: $MESSAGE"