if type -q exa
    function ls --wraps=exa
        command exa --group-directories-first $argv
    end
end
