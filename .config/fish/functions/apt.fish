if type -q aptitude
    function apt --wraps=aptitude
        set aptitude_commands autoclean changelog clean download forbid-version forget-new full-upgrade help hold install keep keep-all markauto purge reinstall remove safe-upgrade search show unhold unmarkauto update
        set apt_commands autoremove changelog depends edit-sources full-upgrade info install list policy purge rdepends remove search show update upgrade
        set command $argv[1]
        if contains $command $aptitude_commands
            aptitude $argv
        else if contains $command $apt_commands
            command apt $argv
        else
            aptitude $argv
        end
    end
end
