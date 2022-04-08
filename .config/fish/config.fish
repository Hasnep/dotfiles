# Prompt colours
set --global hydro_color_duration yellow
set --global hydro_color_error red
set --global hydro_color_git brblack
set --global hydro_color_prompt magenta
set --global hydro_color_pwd cyan
set --global hydro_multiline true

# Configure fzf plugin keybindings
fzf_configure_bindings --directory=\cf --git_log= --git_status=\cg --history=\cr --variables --processes

# Environment variables
set --export --global EDITOR micro
set --global nvm_default_version lts

# Path
fish_add_path $HOME/.local/bin/ $HOME/bin/ $HOME/.cargo/bin/ $HOME/.nimble/bin/ $HOME/go/bin/ $HOME/.juliaup/bin/
