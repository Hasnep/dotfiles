if type -q batcat
    function bat --wraps=batcat
        command batcat $argv
    end
end
