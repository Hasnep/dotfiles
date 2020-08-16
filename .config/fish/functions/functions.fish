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

# Aliases

# Dotfiles
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
complete --command dotfiles --wraps git

# Commandline tools
alias apt="aptitude"
alias grep="grep --color=auto"
alias ls="ls --color=auto --group-directories-first"
alias please="sudo"

# Python commandline tools
alias glances="~/.venvs/glances/bin/python -m glances"
alias jupyterlab="~/.venvs/jupyter/bin/python -m jupyter lab"
alias jupytext="~/.venvs/jupytext/bin/jupytext"

# Python tooling
alias autopep8="~/.venvs/autopep8/bin/python -m autopep8"
alias bandit="~/.venvs/bandit/bin/python -m bandit"
alias black="~/.venvs/black/bin/python -m black"
alias flake8="~/.venvs/flake8/bin/python -m flake8"
alias mypy="~/.venvs/mypy/bin/python -m mypy"
alias pip-compile="~/.venvs/pip-tools/bin/python -m piptools compile"
alias prospector="~/.venvs/prospector/bin/python -m prospector"
alias pycodestyle="~/.venvs/pycodestyle/bin/python -m pycodestyle"
alias pydocstyle="~/.venvs/pydocstyle/bin/python -m pydocstyle"
alias pylama="~/.venvs/pylama/bin/python -m pylama"
alias pylint="~/.venvs/pylint/bin/python -m pylint"
alias pytest="~/.venvs/pytest/bin/python -m pytest"
alias yapf="~/.venvs/yapf/bin/python -m yapf"

# Julia commandline tools
alias pluto="julia --project -e 'import Pluto; Pluto.run()'"
alias jlfmt="julia -e 'import JuliaFormatter; JuliaFormatter.format(\".\")'"
