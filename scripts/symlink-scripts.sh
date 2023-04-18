#!/bin/sh

destination_folder=$HOME/bin
echo "Creating '$destination_folder' if it doesn't exist."
mkdir -p "$destination_folder"

find "$HOME/scripts" -type f | while read -r script
do
    echo "Marking '$script' as executable."
    chmod +x "$script"
    destination="$destination_folder/$(basename "$script" | cut -d '.' -f 1)"
    echo "Symlinking '$script' to '$destination'."
    ln -s -f "$script" "$destination"
done
