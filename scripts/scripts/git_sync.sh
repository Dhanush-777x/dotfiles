#!/bin/bash

# Full path for git
GIT="/usr/bin/git"

# Define the directory where your Obsidian notes are stored
NOTES_DIR="/mnt/3462937862933E14/Obsidian-files/Dhanushsm-vault"

# Navigate to your Obsidian vault (Git repo)
cd $NOTES_DIR || exit

# Pull the latest changes from GitHub to ensure no conflicts
$GIT pull origin main --no-edit

# Check for changes in the local directory (Obsidian vault)
if [[ -n $($GIT status --porcelain) ]]; then
    $GIT add .
    $GIT commit -m "Auto-sync from $(hostname) - $(date)"
    $GIT push origin main
fi

