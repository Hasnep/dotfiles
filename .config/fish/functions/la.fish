if type -q exa
    function la --wraps=exa
        command exa --long --all --header $argv
    end
else
    function la --wraps=ls
        command ls -lAh --almost-all --human-readable -l $argv
    end
end
