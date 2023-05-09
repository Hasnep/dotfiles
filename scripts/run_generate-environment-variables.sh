#!/usr/bin/sh

$HOME/bin/generate-export-script --shell fish  --output $HOME/.config/fish/environment-variables.fish $HOME/.config/environment-variables/environment-variables.json
$HOME/bin/generate-export-script --shell posix --output $HOME/.profile                                $HOME/.config/environment-variables/environment-variables.json
