function pip-recompile -a VENV -d "Recompile requirements for a pip venv in ~/.venvs/<venv>"
    set VENV_PATH $HOME/.venvs/$VENV
    echo "Compiling requirements"
    $VENV_PATH/bin/python -m pip install pip-tools
    $VENV_PATH/bin/python -m piptools compile "requirements.in"
    echo "Installing requirements"
    $VENV_PATH/bin/python -m pip install -r "requirements.txt"
end

function pip-recreate -a VENV -d "Delete and recompile a pip venv in ~/.venvs/<venv>"
    set VENV_PATH $HOME/.venvs/$VENV
    echo "Removing venv at $VENV_PATH"
    rm -rf $VENV_PATH
    echo "Creating new venv at $VENV_PATH"
    python3 -m venv $VENV_PATH
    pip-recompile $VENV
end

# My venv-tools
alias venv-auto=venv-tools auto
alias venv-create=venv-tools create
