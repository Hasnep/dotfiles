if type -q exa
    function ls --wraps=exa
        command exa $argv
    end
end
