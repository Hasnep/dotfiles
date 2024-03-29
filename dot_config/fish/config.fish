# Set XDG environment variables
set environment_variables_script $HOME/.config/fish/environment-variables.fish
if test -f $environment_variables_script
    source $environment_variables_script
else
    echo "Environment variables script not found at '$environment_variables_script'."
end

# Add abbreviations
if type --query --no-functions trash
    abbr --global --add rip 'trash put'
end

# Configure fzf plugin keybindings
if type --query --no-functions fzf
    if type --query fzf_configure_bindings
        fzf_configure_bindings --directory=\cf --git_log= --git_status=\cg --history=\cr --variables --processes
    end
end

# Set default editor
if type --query --no-functions micro
    set --export --global EDITOR micro
end
