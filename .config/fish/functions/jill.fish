function jill --wraps jill
    if not type --no-functions --query jill
        pipx install jill
    end
    command jill $argv
end
