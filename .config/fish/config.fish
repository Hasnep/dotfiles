# Prompt colours
set --global hydro_color_duration yellow
set --global hydro_color_error red
set --global hydro_color_git brblack
set --global hydro_color_prompt magenta
set --global hydro_color_pwd cyan

# Environment variables
set --export --global EDITOR micro
set --global nvm_default_version lts

# Path
fish_add_path $HOME/.local/bin/ $HOME/bin/ $HOME/.cargo/bin/ $HOME/.nimble/bin/ $HOME/.juliaup/bin/
