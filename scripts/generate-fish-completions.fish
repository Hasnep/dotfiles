#!/usr/bin/env fish

if type -q trash
    trash completions fish >$XDG_CONFIG_HOME/fish/completions/trash.fish
end

if type -q just
    just --completions fish >$XDG_CONFIG_HOME/fish/completions/just.fish
end

if type -q antidot
    antidot completion fish >$XDG_CONFIG_HOME/fish/completions/antidot.fish
end
