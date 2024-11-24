#!/bin/bash

# Get the current directory
current_dir=$(pwd)

# Loop through each subdirectory in the current directory
for dir in */; do
    # Ensure it's a directory
    if [ -d "$dir" ]; then
        echo "Processing directory: $dir"
        # Change to the directory
        cd "$dir"
        
        # Find the ext_ file
        ext_file=$(ls ext_* 2>/dev/null)
        
        # Check if the ext_ file exists
        if [ -n "$ext_file" ]; then
            echo "Found file: $ext_file"
            # Apply the cleaning script to the ext_ file
            ../clean_up.sh "$ext_file"
        else
            echo "No ext_ file found in directory: $dir"
        fi
        
        # Return to the parent directory
        cd "$current_dir"
    fi
done
