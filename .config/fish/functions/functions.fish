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
    set VENV_PATH $HOME/.venvs/$VENV
    echo "Compiling requirements"
    $VENV_PATH/bin/python -m pip install pip-tools
    $VENV_PATH/bin/python -m piptools compile "requirements.in"
    echo "Installing requirements"
    $VENV_PATH/bin/python -m pip install -r "requirements.txt"
end

function pip-recreate -a "VENV" -d "Delete and recompile a pip venv in ~/.venvs/<venv>"
    set VENV_PATH $HOME/.venvs/$VENV
    echo "Removing venv at $VENV_PATH"
    rm -rf $VENV_PATH
    echo "Creating new venv at $VENV_PATH"
    python3 -m venv $VENV_PATH
    pip-recompile $VENV
end

function update-venvs -d "Update all my custom venvs"
    create-venv awscli
    create-venv bpytop
    create-venv glances
    create-venv jill
    create-venv jupyter jupyter jupyterlab
    create-venv jupytext jupyter jupytext
    create-venv proselint

    # Dev tools
    create-venv black
    create-venv flake8
    create-venv mypy
    create-venv pip-tools
    create-venv pydocstyle
    create-venv pytest
    create-venv safety
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
alias bpytop="~/.venvs/bpytop/bin/python -m bpytop"
alias glances="~/.venvs/glances/bin/python -m glances"
alias jill="~/.venvs/jill/bin/python -m jill"
alias jupyterlab="~/.venvs/jupyter/bin/python -m jupyter lab"
alias jupytext="~/.venvs/jupytext/bin/jupytext"
alias proselint="~/.venvs/proselint/bin/python -m proselint"

# Python tooling
alias black="~/.venvs/black/bin/python -m black"
alias flake8="~/.venvs/flake8/bin/python -m flake8"
alias mypy="~/.venvs/mypy/bin/python -m mypy"
alias pip-compile="~/.venvs/pip-tools/bin/python -m piptools compile"
alias pydocstyle="~/.venvs/pydocstyle/bin/python -m pydocstyle"
alias pytest="~/.venvs/pytest/bin/python -m pytest"
alias safety="~/.venvs/safety/bin/python -m safety"

# Julia commandline tools
alias pluto="julia --project -e 'import Pkg; Pkg.update(\"Pluto\"); import Pluto; Pluto.run()'"
alias jlfmt="julia --startup-file=no -q --compile=min -O0 -e 'import JuliaFormatter; JuliaFormatter.format(\".\", margin = 120, always_for_in = true, whitespace_typedefs = true, whitespace_ops_in_indices = true)'"
