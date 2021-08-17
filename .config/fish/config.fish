begin
    set -l terminal_emulator (ps -p (ps -p $fish_pid -o ppid= | tr -d \[:space:\]) -o args=)
    switch $terminal_emulator
        case tilix alacritty
            neofetch
        case "*code*"
            git rev-parse --git-dir &>/dev/null && onefetch
    end
end

set -xg EDITOR micro

fish_add_path $HOME/bin $HOME/.cargo/bin/ $HOME/.nimble/bin/
