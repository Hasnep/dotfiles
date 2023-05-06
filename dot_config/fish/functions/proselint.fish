function proselint --wraps proselint
    if not type --no-functions --query proselint
        pipx install proselint
    end
    command proselint $argv
end
