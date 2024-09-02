#!/bin/sh

# Define source and destination directories
SOURCE="$1"
DESTINATION="$2"

# Check if the directories are different
if ! rsync -rnc --delete "$SOURCE/" "$DESTINATION/"; then
    echo "Directories are different. Syncing..."
    rsync -r --delete "$SOURCE/" "$DESTINATION/"
else
    echo "Directories are the same. No sync needed."
fi

