#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title Get Teams Presence
# @raycast.mode fullOutput
# @raycast.icon 🟢
# @raycast.packageName Microsoft Teams

LOG_FILE=~/teams-raycast.log
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

PRESENCE=$(curl -s -X GET \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  "https://graph.microsoft.com/v1.0/me/presence" | jq -r '.availability')

if [[ -n "$PRESENCE" ]]; then
    echo "[$(date)] Current presence: $PRESENCE" >> "$LOG_FILE"
    echo "Current presence: $PRESENCE"
else
    echo "[$(date)] Error: Failed to retrieve presence." >> "$LOG_FILE"
    echo "Error: Failed to retrieve presence."
fi