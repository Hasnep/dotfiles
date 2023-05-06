if type -q fdfind
    function fd --wraps=fdfind
        command fdfind $argv
    end
end
