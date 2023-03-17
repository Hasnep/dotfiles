function activate --description "Activate a Python venv"
    # Use venv in project directory
    if test -d ./.venv
        set venv_path (realpath "./.venv")
    else if test -d ./venv
        set venv_path (realpath "./venv")

        # Use Poetry
    else if test -e ./pyproject.toml
        set venv_path (poetry env info --path)

        # Use venv in ~/.venvs/
    else
        if test (count $argv) = 0
            # If the name of the venv wasn't specified then try using the name of the current directory
            set venv_name (basename (pwd))
        else
            set venv_name $argv[1]
        end
        set venv_path $HOME/.venvs/$venv_name
    end

    # If the virtual environment doesn't exist then raise and error
    if not test -d $venv_path
        echo "Could not find a virtual environment at `$venv_path`."
        return 1
    end

    echo "Activating venv in `$venv_path`."
    source $venv_path/bin/activate.fish
end
