function fish_greeting
    begin
        set -l terminal_emulator (ps -p (ps -p $fish_pid -o ppid= | tr -d \[:space:\]) -o args=)
        switch $terminal_emulator
            case tilix alacritty x-terminal-emulator
                macchina --custom-ascii "~/.config/macchina/ascii/fish.txt"
            case "*code*"
                git rev-parse --git-dir &>/dev/null && onefetch
        end
    end
end
