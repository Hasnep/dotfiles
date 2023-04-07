function fish_prompt
    set --function previous_command_exit_code $pipestatus

    # Configs
    set --function config_working_directory_colour cyan
    set --function config_prompt_colour magenta
    set --function config_error_colour red
    set --function config_git_branch_colour brblack
    set --function config_prompt_character "❱"
    set --function config_command_duration_threshold_milliseconds 1000 # 1 second

    # Reset colour
    set --function reset_colour (set_color normal)

    # Working directory
    set --function working_directory_colour (set_color $config_working_directory_colour)
    set --function working_directory $PWD
    if test "$working_directory" != "$HOME"
        set --function working_directory (dirname $working_directory)"/"(set_color --bold)(basename $working_directory)
    end
    set --function working_directory (string replace --ignore-case -- ~ \~ $working_directory)
    set --function working_directory_suffix $reset_colour
    set --function part_working_directory $working_directory_colour$working_directory$working_directory_suffix

    # Git branch
    if type --query --no-functions git
        set --function git_branch_prefix " "
        set --function git_branch_colour (set_color $config_git_branch_colour)
        set --function git_branch (command git symbolic-ref --short HEAD 2>/dev/null)
        set --function git_branch_suffix $reset_colour
    end
    set --function part_git_branch $git_branch_prefix$git_branch_colour$git_branch$git_branch_suffix

    # Previous command duration
    if test "$CMD_DURATION" -gt "$config_command_duration_threshold_milliseconds"
        set --function duration_seconds (math --scale=1 $CMD_DURATION/1000 % 60)
        set --function duration_prefix " "
        set --function duration_colour (set_color $config_command_duration_colour)
        set --function duration_suffix "s$reset_colour"
    end
    set --function part_duration $duration_prefix$duration_colour$duration_seconds$duration_suffix

    # Previous command status
    if test "$previous_command_exit_code" -eq 0
        set --function prompt_colour (set_color $config_prompt_colour)
        set --function part_exit_code
    else
        set --function prompt_colour (set_color $config_error_colour)
        set --function exit_code_prefix " "
        set --function exit_code_colour $prompt_colour
        set --function exit_code "[$previous_command_exit_code]"
        set --function exit_code_suffix "$reset_colour"
        set --function part_exit_code $exit_code_prefix$exit_code_colour$exit_code$exit_code_suffix
    end

    # Prompt
    set --function prompt_suffix "$reset_colour "
    set --function part_prompt "$prompt_colour$config_prompt_character$prompt_suffix"

    # Print prompt

    echo -e "$part_working_directory$part_git_branch$part_duration$part_exit_code\n$part_prompt"
end
