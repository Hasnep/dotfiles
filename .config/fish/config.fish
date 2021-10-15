begin
    set -l terminal_emulator (ps -p (ps -p $fish_pid -o ppid= | tr -d \[:space:\]) -o args=)
    switch $terminal_emulator
        case tilix alacritty x-terminal-emulator
            macchina
        case "*code*"
            git rev-parse --git-dir &>/dev/null && onefetch
    end
end

set -xg EDITOR micro
set -xg nvm_default_version lts

fish_add_path $HOME/.local/bin/ $HOME/bin/ $HOME/.cargo/bin/ $HOME/.nimble/bin/
