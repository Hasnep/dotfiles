# Configure fzf plugin keybindings
fzf_configure_bindings --directory=\cf --git_log= --git_status=\cg --history=\cr --variables --processes

# Set default editor
if type --query --no-functions micro
    set --export --global EDITOR micro
end

# Set XDG environment variables
source $HOME/.config/xdg-config.env

# Add folders to path
fish_add_path \
    $HOME/bin/ \
    $HOME/.local/bin/ \
    $HOME/.nimble/bin/ \
    $XDG_DATA_HOME/cargo/bin/ \
    $XDG_DATA_HOME/go/bin/ \
    $XDG_DATA_HOME/julia/juliaup/bin/

# Add abbreviations
if type --query --no-functions trash
    abbr --global --add rip 'trash put'
end

# Activate Guix
if type --query --no-functions guix
    set activate_guix_script_path $XDG_CONFIG_HOME/guix-profiles/activate-guix.fish
    if test -f $activate_guix_script_path
        source $XDG_CONFIG_HOME/guix-profiles/activate-guix.fish
    end
end
