function ar --wraps=autorestic
    command autorestic --config="$XDG_CONFIG_HOME/autorestic/autorestic.yaml" --verbose $argv
end
