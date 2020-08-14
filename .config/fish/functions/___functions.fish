function activate -a "VENV" -d "Activate a Python venv in ~/.venvs/<venv>"
    source ~/.venvs/$VENV/bin/activate.fish
end

function create-venv -a "VENV" "PACKAGES" -d "create-venv <venv> <packages>"
    mkdir -p $HOME/.venvs/
    set VENV_PATH $HOME/.venvs/$VENV
    echo "Creating venv at $VENV_PATH"
    python3 -m venv $VENV_PATH
    if test -n "$PACKAGES"
        echo "Installing $PACKAGES"
        $HOME/.venvs/$VENV/bin/python -m pip install -U $PACKAGES
    else
        echo "Installing $VENV"
        $HOME/.venvs/$VENV/bin/python -m pip install -U $VENV
    end
    echo "Done creating venv"
end

function pip-recompile -a "VENV" -d "Recompile requirements for a pip venv in ~/.venvs/<venv>"
    set set VENV_PATH $HOME/.venvs/$VENV $HOME/.venvs/$VENV
    echo "Compiling requirements"
    $VENV_PATH/bin/python -m pip install pip-tools
    $VENV_PATH/bin/python -m piptools compile "requirements.in"
    echo "Installing requirements"
    $VENV_PATH/bin/python -m pip install -r "requirements.txt"
end

function pip-recreate -a "VENV" -d "Delete and recompile a pip venv in ~/.venvs/<venv>"
    set set VENV_PATH $HOME/.venvs/$VENV $HOME/.venvs/$VENV
    echo "Removing venv at $VENV_PATH"
    rm -rf $VENV_PATH
    echo "Creating new venv at $VENV_PATH"
    python3 -m venv $VENV_PATH
    pip-recompile $VENV_NAME
end

function smart-add-ppa -a "PPA_URL" -d "Remove a PPA and re-add it"
    echo "Removing $PPA_URL"
    sudo add-apt-repository --remove -y $PPA_URL
    echo "Adding $PPA_URL"
    sudo add-apt-repository -y $PPA_URL
end
