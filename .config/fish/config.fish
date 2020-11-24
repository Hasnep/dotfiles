begin
    set -l terminal_emulator (ps -p (ps -p $fish_pid -o ppid= | tr -d \[:space:\]) -o args=)
    switch $terminal_emulator
        case "tilix"
            neofetch
        case "*code*"
            git rev-parse --git-dir &>/dev/null && onefetch
    end
end

set -xg EDITOR /snap/bin/micro
