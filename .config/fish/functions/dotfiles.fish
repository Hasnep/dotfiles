function dotfiles --wraps=git
    command git --git-dir=$HOME/.dotfiles --work-tree=$HOME $argv
end
