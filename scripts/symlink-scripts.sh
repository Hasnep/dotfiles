#!/bin/sh

find "$HOME/scripts" -type f | while read -r script
do
    echo "Marking '$script' as executable."
    chmod +x "$script"
    destination="$HOME/.local/bin/$(basename "$script" | cut -d '.' -f 1)"
    echo "Symlinking '$script' to '$destination'."
    ln -s -f "$script" "$destination"
done
