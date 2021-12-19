function bpytop --wraps bpytop
    if not type --no-functions --query bpytop
        pipx install bpytop
    end
    command bpytop $argv
end
