function asciinema --wraps asciinema
    if not type --no-functions --query asciinema
        pipx install asciinema
    end
    command asciinema $argv
end
