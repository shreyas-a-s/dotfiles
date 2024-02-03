#!/usr/bin/env bash

# Change directory
SCRIPT_DIR=$(dirname -- "$( readlink -f -- "$0"; )") && cd "$SCRIPT_DIR" || exit

# Your copied configuration directory
config_backup_dir=$(pwd)/../.config

# Your target directory (where you want to create symlinks)
config_orig_dir=~/.config

# Create the target directory if it doesn't exist
mkdir -p "$config_orig_dir"

# Iterate over files in config_backup_dir
for file in "$config_backup_dir"/*; do
  # Extract the file name
  filename=$(basename "$file")

  # Check if the file exists in config_orig_dir
  if [ -e "$config_orig_dir/$filename" ]; then
    # File exists in config_orig_dir, delete it and create a symlink
    rm "$config_orig_dir/$filename"
    ln -s "$config_backup_dir/$filename" "$config_orig_dir/$filename"
    echo "Replaced existing file: $filename"
  else
    # File doesn't exist in config_orig_dir, create a symlink
    ln -s "$config_backup_dir/$filename" "$config_orig_dir/$filename"
    echo "Created symlink: $filename"
  fi
done

echo "Symlinks creation completed."

