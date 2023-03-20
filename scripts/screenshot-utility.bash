#!/usr/bin/env bash

output_directory="$HOME/Pictures"
output_file_name="$(date '+%Y-%m-%d-%H-%M-%S').png"
output_file_path="$output_directory/$output_file_name"
maim --select $output_file_path && cat $output_file_path | xclip -selection clipboard -t image/png
