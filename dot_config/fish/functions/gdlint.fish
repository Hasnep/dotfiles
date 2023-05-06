function gdlint --wraps gdlint
    if not type --no-functions --query gdlint
        pipx install gdtoolkit
    end
    command gdlint $argv
end
