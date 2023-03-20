function fish_greeting
    begin
        if type -q ps
            set -l terminal_emulator (test $TERM = alacritty && echo alacritty || echo (ps -p (ps -p $fish_pid -o ppid= | tr -d \[:space:\]) -o args=))
            switch $terminal_emulator
                case alacritty
                    if type -q macchina
                        macchina
                    end
                case "*code*" "*Visual Studio Code.app*"
                    if type -q git; and type -q onefetch
                        git rev-parse --git-dir &>/dev/null && onefetch
                    end
            end
        end
    end
end
