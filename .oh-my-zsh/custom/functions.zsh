# create-venv <venv-name> <packages>
function create-venv {
	VENV_NAME=${1:?"Specify the name of the venv."}
	shift
	PACKAGE_NAMES=${@:-$VENV_NAME}
	python3 -m venv $HOME/.venvs/$VENV_NAME
	$(echo "$HOME/.venvs/$VENV_NAME/bin/python -m pip install -U $PACKAGE_NAMES")
}

# Activate a Python venv in ~/.venvs/<name of venv>
function activate {
    source ~/.venvs/${1:?"Error: Specify the name of the venv."}/bin/activate
}

# Recompile requirements for a pip venv in ~/.venvs/<name of venv>
function pip-recompile {
    VENV_NAME=${1:?"Error: Specify the name of the venv."}
    echo "Compiling requirements" \
    && $HOME/.venvs/$VENV_NAME/bin/python -m pip install pip-tools \
    && $HOME/.venvs/$VENV_NAME/bin/python -m piptools compile \
    && echo "Installing requirements" \
    && $HOME/.venvs/$VENV_NAME/bin/python -m pip install -r requirements.txt
}

# Delete and recompile a pip venv in ~/.venvs/<name of venv>
function pip-recreate {
    VENV_NAME=${1:?"Error: Specify the name of the venv."}
    echo "Removing venv at $HOME/.venvs/$VENV_NAME/" \
    && rm -rf $HOME/.venvs/$VENV_NAME/ \
    && echo "Creating new venv at $HOME/.venvs/$VENV_NAME/" \
    && /usr/bin/python3 -m venv $HOME/.venvs/$VENV_NAME/ \
    && piprecompile $VENV_NAME
}

# Remove a PPA and re-add it
function smart-add-ppa {
    PPA_URL=${1:?"Error: Specify the ppa URL."} && \
    echo "Removing $PPA_URL" && \
    sudo add-apt-repository --remove -y $PPA_URL && \
    echo "Adding $PPA_URL" && \
    sudo add-apt-repository -y $PPA_URL
}
