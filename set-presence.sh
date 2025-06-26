#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title Set Teams Presence
# @raycast.mode fullOutput
# @raycast.argument1 { "type": "text", "placeholder": "Status (Available, Busy, DoNotDisturb, BeRightBack, Away)" }
# @raycast.icon 🔵
# @raycast.packageName Microsoft Teams

STATUS="$1"
LOG_FILE=~/teams-raycast.log

if [[ -z "$STATUS" ]]; then
    echo "[$(date)] Error: Status is required." >> "$LOG_FILE"
    echo "Error: Status is required."
    exit 1
fi

VALID_STATUSES=("Available" "Busy" "DoNotDisturb" "BeRightBack" "Away")
if [[ ! " ${VALID_STATUSES[@]} " =~ " $STATUS " ]]; then
    echo "[$(date)] Error: Invalid status. Valid options: ${VALID_STATUSES[*]}" >> "$LOG_FILE"
    echo "Error: Invalid status. Valid options: ${VALID_STATUSES[*]}"
    exit 1
fi

source ~/.teams-raycast-config

if [[ -z "$CLIENT_ID" || -z "$CLIENT_SECRET" || -z "$TENANT_ID" ]]; then
    echo "[$(date)] Error: Missing required environment variables." >> "$LOG_FILE"
    echo "Error: Missing required environment variables. Please set CLIENT_ID, CLIENT_SECRET, and TENANT_ID."
    exit 1
fi

TOKEN=$(curl -s -X POST \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=client_credentials&client_id=${CLIENT_ID}&client_secret=${CLIENT_SECRET}&scope=https://graph.microsoft.com/.default" \
  "https://login.microsoftonline.com/${TENANT_ID}/oauth2/v2.0/token" | jq -r '.access_token')

if [[ -z "$TOKEN" ]]; then
    echo "[$(date)] Error: Failed to obtain access token." >> "$LOG_FILE"
    echo "Error: Failed to obtain access token."
    exit 1
fi

RESPONSE=$(curl -s -X POST \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d "{\"sessionId\":\"raycast-session\",\"availability\":\"$STATUS\",\"activity\":\"$STATUS\"}" \
  "https://graph.microsoft.com/v1.0/me/presence/setPresence")

if [[ -z "$RESPONSE" || "$RESPONSE" == *"error"* ]]; then
    echo "[$(date)] Error: Failed to set presence. Response: $RESPONSE" >> "$LOG_FILE"
    echo "Error: Failed to set presence. Response: $RESPONSE"
    exit 1
fi

echo "[$(date)] Presence set to: $STATUS" >> "$LOG_FILE"
echo "Presence set to: $STATUS"