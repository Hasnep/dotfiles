# Prompt colours
set --global hydro_color_duration yellow
set --global hydro_color_error red
set --global hydro_color_git brblack
set --global hydro_color_prompt magenta
set --global hydro_color_pwd cyan
set --global hydro_multiline true

# Configure fzf plugin keybindings
fzf_configure_bindings --directory=\cf --git_log= --git_status=\cg --history=\cr --variables --processes

# Set default editor
if type --query --no-functions micro
    set --export --global EDITOR micro
end

# Environment variables
set --global nvm_default_version lts

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
