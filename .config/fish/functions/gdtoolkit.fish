function gdtoolkit --wraps gdtoolkit
    if not type --no-functions --query gdtoolkit
        pipx install gdtoolkit
    end
    command gdtoolkit $argv
end
