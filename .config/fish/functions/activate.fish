function activate --description "Activate a Python venv"
    # Use Poetry
    if test -e ./pyproject.toml
        set venv_path (poetry env info --path)

        # Use venv in project firectory
    else if test -d ./.venv
        set venv_path realpath "./.venv"
    else if test -d ./venv
        set venv_path realpath "./venv"

        # Use venv in ~/.venvs/
    else
        if test (count $argv) = 0
            set venv_name (basename (pwd))
        else
            set venv_name $argv[1]
        end
        set venv_path $HOME/.venvs/$venv_name
    end

    echo "Activating venv in $venv_path"
    source $venv_path/bin/activate.fish
end
