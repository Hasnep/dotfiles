function fish_greeting
    if type --query --no-functions ps and type --query --no-functions tail
        set terminal_emulator (basename "/"(ps -o cmd -f -p (cat /proc/(echo %self)/stat | string split --fields 4 " ") | tail -1 | string split --fields 1 " "))
        switch $terminal_emulator
            case login
                return
            case alacritty foot
                if type --query --no-functions macchina
                    macchina
                    return
                else
                    echo "Command 'macchina' not found."
                end
            case code codium
                if type --query --no-functions git and type --query --no-functions onefetch
                    git rev-parse --git-dir &>/dev/null && onefetch
                    return
                else
                    echo "Commands 'git' and 'onefetch' required."
                end
            case '*'
                # echo "Terminal emulator '$terminal_emulator' is not supported by greeting."
                return
        end
    else
        echo "Commands 'ps' and 'tail' required for greeting."
        return
    end
end
