function gdparse --wraps gdparse
    if not type --no-functions --query gdparse
        pipx install gdtoolkit
    end
    command gdparse $argv
end
