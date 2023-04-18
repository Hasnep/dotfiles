# Configure fzf plugin keybindings
fzf_configure_bindings --directory=\cf --git_log= --git_status=\cg --history=\cr --variables --processes

# Set default editor
if type --query --no-functions micro
    set --export --global EDITOR micro
end

# Set XDG environment variables
source $HOME/.config/xdg-config.env

# Add folders to path
fish_add_path --move $XDG_DATA_HOME/cargo/bin/
fish_add_path --move $XDG_DATA_HOME/juliaup/bin/
# Nix
fish_add_path --move $XDG_DATA_HOME/nix/bin
# System packages
fish_add_path --move /usr/bin/

# Guix
if type --query --no-functions guix
    if type --query activate-guix
        activate-guix
    end
end

fish_add_path --move $HOME/.local/bin/
fish_add_path --move $HOME/bin/

# Add abbreviations
if type --query --no-functions trash
    abbr --global --add rip 'trash put'
end
