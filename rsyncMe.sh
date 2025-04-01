#!/bin/bash

# Define variables
SOURCE_PATH="~/"
REMOTE_USER="put your user name here"
REMOTE_HOST="destination IP address "
DEST_PATH="/Volumes/external/Users/youtusername"

# Array of folders to exclude
EXCLUDE_FOLDERS=("Library" "Movies" "Music" "OneDrive*" "SentinelOne_Logs")

# Build the exclude options
EXCLUDE_OPTS=""
for folder in "${EXCLUDE_FOLDERS[@]}"; do
    EXCLUDE_OPTS="$EXCLUDE_OPTS --exclude=$folder"
done

# Full rsync command
RSYNC_CMD="rsync -avz $EXCLUDE_OPTS $SOURCE_PATH $REMOTE_USER@$REMOTE_HOST:$DEST_PATH"

# Print the command for debugging (optional)
echo "Running: $RSYNC_CMD"

# Execute the command
eval "$RSYNC_CMD"

# Check the exit status
if [ $? -eq 0 ]; then
    echo "Sync completed successfully!"
else
    echo "An error occurred during sync."
fi