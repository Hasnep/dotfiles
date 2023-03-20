#!/usr/bin/env fish

for script in $HOME/scripts/*
    echo "Marking '$script' as executable."
    chmod +x $script
    set destination "$HOME/.local/bin/"(basename $script | string split -r -m1 .)[1]
    echo "Symlinking '$script' to '$destination'."
    ln --symbolic --force $script $destination
end
