function gdformat --wraps gdformat
    if not type --no-functions --query gdformat
        pipx install gdtoolkit
    end
    command gdformat $argv
end
