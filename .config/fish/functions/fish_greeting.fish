function fish_greeting
    if test $TERM = alacritty -o $TERM = foot
        if type --query --no-functions macchina
            macchina
        end
    else
        if type --query --no-functions ps and type --query --no-functions tail
            set terminal_emulator (basename "/"(ps -o cmd -f -p (cat /proc/(echo %self)/stat | string split --fields 4 " ") | tail -1 | string split --fields 1 " "))
            if test $terminal_emulator = code -o $terminal_emulator = codium
                if type --query --no-functions git and type --query --no-functions onefetch
                    git rev-parse --git-dir &>/dev/null && onefetch
                end
            end
        end
    end
end
