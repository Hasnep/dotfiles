function mkvtomp4 --argument-names="input_file_path" --argument-names="output_file_path"
    # If you didn't specify an output path then use the same folder and add the mp4 extension
    if not test -n "$output_file_path"
        # Change the input file's path to an absolute path
        set input_file_path (realpath $input_file_path)
        set input_file_directory (dirname $input_file_path) && echo input_file_directory=$input_file_directory
        set input_file_name_no_extension (basename $input_file_path .mkv) && echo input_file_name_no_extension=$input_file_name_no_extension
        set output_file_path "$input_file_directory/$input_file_name_no_extension.mp4" && echo output_file_path=$output_file_path
    end
    ffmpeg -i $input_file_path -codec copy $output_file_path
end
