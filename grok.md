Due to the limitations of this text-based interface, I cannot provide direct downloadable links to individual files or a zip file that can be clicked and downloaded as you would from a website. The previous attempts to deliver a zip file as an artifact resulted in a text file instead of a valid archive, as confirmed by the `file` command output. However, I can make this process as convenient as possible by providing the individual file contents here in a format you can easily copy and paste into files on your Mac. This way, you can create the `teams-raycast-scripts` folder and populate it with each script manually.

Below, I'll list each file with its full content. You can copy each block of text, create a corresponding `.sh` file in the `~/teams-raycast-scripts` directory, and paste the content. This approach ensures you get all the files without relying on a download link or zip file.

---

### Instructions to Download Individual Files Manually

1. **Create the Directory**:
   - Open Terminal and run:
     ```bash
     mkdir -p ~/teams-raycast-scripts
     cd ~/teams-raycast-scripts
     ```

2. **Create and Populate Each File**:
   - For each file listed below, create it using `touch` (e.g., `touch open-teams.sh`), open it in a text editor (e.g., `nano open-teams.sh` or TextEdit), paste the content, save, and exit.
   - Example:
     ```bash
     touch open-teams.sh
     nano open-teams.sh
     ```
     Paste the content, press `Ctrl+O`, hit `Enter` to save, then `Ctrl+X` to exit.

3. **Make Files Executable**:
   - After creating all files, run:
     ```bash
     chmod +x *.sh
     ```

4. **Add to Raycast**:
   - Open Raycast Preferences > Extensions > Click "+" > Select "Add Script Directory" > Choose `~/teams-raycast-scripts`.

5. **Configure API Scripts**:
   - Create `~/.teams-raycast-config` with your Azure AD credentials:
     ```bash
     touch ~/.teams-raycast-config
     nano ~/.teams-raycast-config
     ```
     Paste:
     ```bash
     export CLIENT_ID="your_client_id"
     export CLIENT_SECRET="your_client_secret"
     export TENANT_ID="your_tenant_id"
     ```
     Save and exit. Replace placeholders with your credentials.
   - Install `jq` for API scripts:
     ```bash
     brew install jq
     ```

6. **Test**:
   - Run scripts via Raycast (e.g., "Open Microsoft Teams") and check `~/teams-raycast.log` for errors.

---

### Individual File Contents

#### `README.md`
```markdown
# Microsoft Teams Raycast Script Library

This is a collection of scripts for automating Microsoft Teams tasks using Raycast, created on June 25, 2025.

## Installation

1. **Ensure Folder is in Place**: The scripts are in the `teams-raycast-scripts` folder at `~/teams-raycast-scripts`.
2. **Make Scripts Executable**: Open a terminal, navigate to the folder (`cd ~/teams-raycast-scripts`), and run `chmod +x *.sh`.
3. **Add to Raycast**:
   - Open Raycast Preferences.
   - Go to Extensions tab.
   - Click the '+' button and select 'Add Script Directory'.
   - Choose the `~/teams-raycast-scripts` folder.
4. **Configure API Scripts** (for `get-presence.sh` and `set-presence.sh`):
   - Register an app in Azure AD to get `CLIENT_ID`, `CLIENT_SECRET`, and `TENANT_ID`.
   - Create a file named `.teams-raycast-config` in your home directory (`~/.teams-raycast-config`) with:
     ```bash
     export CLIENT_ID="your_client_id"
     export CLIENT_SECRET="your_client_secret"
     export TENANT_ID="your_tenant_id"
     ```
   - Grant necessary permissions in Azure AD (e.g., Presence.ReadWrite, User.Read).
5. **Install Dependencies**: Ensure `jq` is installed for API scripts (`brew install jq`).

## Usage Notes

- Assign global hotkeys to scripts in Raycast Preferences for quick access.
- Ensure Microsoft Teams is installed and running (e.g., check at 08:12 PM EDT on June 25, 2025, or later).
- Some scripts require macOS accessibility permissions for AppleScript automation.
- Scripts are compatible with both classic and new Teams apps.
- Logs are saved to `~/teams-raycast.log` for troubleshooting.

## Scripts Included

- Basic Management: `open-teams.sh`, `set-status.sh`, `join-meeting.sh`
- Meeting Controls: `toggle-mute.sh`, `toggle-video.sh`, `leave-meeting.sh`
- Calendar: `schedule-meeting.sh`, `show-todays-meetings.sh`
- Chat: `search-chat.sh`, `send-message.sh`
- Files: `open-files.sh`, `share-screen.sh`
- Graph API: `get-presence.sh`, `set-presence.sh`
- Workflow: `morning-setup.sh`, `end-day-cleanup.sh`
- URL Schemes: `join-meeting-by-id.sh`, `open-channel.sh`

## Troubleshooting

- Check `~/teams-raycast.log` for debug logs if a script fails.
- Verify Teams is running before executing scripts.
- Ensure API credentials are correctly set for API-based scripts.
- If scripts fail due to UI changes, update the AppleScript commands.

For more details, see the Raycast documentation or Microsoft Graph API guides.


---

### Additional Notes
- **Time Context**: It's 08:12 PM EDT on June 25, 2025. You can test these scripts now or schedule `morning-setup.sh` for tomorrow morning.
- **Permissions**: Some scripts require macOS accessibility permissions. Go to System Settings > Privacy & Security > Accessibility and add Raycast if prompted.
- **Dependencies**: Ensure Homebrew and `jq` are installed for API scripts. Install Homebrew if needed:
  ```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```
- **Troubleshooting**: If a script fails, check `~/teams-raycast.log` and share the output for further assistance.

---
