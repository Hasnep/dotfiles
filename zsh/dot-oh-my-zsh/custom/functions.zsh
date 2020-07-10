# Activate a Python venv in ~/.venvs/<name of venv>
function activate {
    source ~/.venvs/${1:?"Error: Specify the name of the venv."}/bin/activate
}

# Recompile requirements for a pip venv in ~/.venvs/<name of venv>
function piprecompile {
    VENV_NAME=${1:?"Error: Specify the name of the venv."}
    echo "Compiling requirements" \
    && $HOME/.venvs/$VENV_NAME/bin/python -m pip install pip-tools \
    && $HOME/.venvs/$VENV_NAME/bin/python -m piptools compile \
    && echo "Installing requirements" \
    && $HOME/.venvs/$VENV_NAME/bin/python -m pip install -r requirements.txt
}

# Delete and recompile a pip venv in ~/.venvs/<name of venv>
function piprecreate {
    VENV_NAME=${1:?"Error: Specify the name of the venv."}
    echo "Removing venv at $HOME/.venvs/$VENV_NAME/" \
    && rm -rf $HOME/.venvs/$VENV_NAME/ \
    && echo "Creating new venv at $HOME/.venvs/$VENV_NAME/" \
    && /usr/bin/python3 -m venv $HOME/.venvs/$VENV_NAME/ \
    && piprecompile $VENV_NAME
}
