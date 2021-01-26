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

# My venv-tools
alias venv-tools="python3 ~/.local/bin/venv-tools.py"
alias venv-auto="python3 ~/.local/bin/venv-tools.py auto"
alias venv-create="python3 ~/.local/bin/venv-tools.py create"

function update-venvs -d "Update all my custom venvs"
    venv-tools auto ansible
    venv-tools auto awscli
    venv-tools auto bpytop
    venv-tools auto glances
    venv-tools auto jill
    venv-tools auto jupyter --packages jupyter jupyterlab
    venv-tools auto jupytext --packages jupyter jupytext
    venv-tools auto proselint
    venv-tools auto speedtest-cli

    # Dev tools
    venv-tools auto black
    venv-tools auto flake8
    venv-tools auto isort
    venv-tools auto mypy
    venv-tools auto pip-tools
    venv-tools auto pydocstyle
    venv-tools auto pytest
    venv-tools auto safety
end

# Dotfiles
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
complete --command dotfiles --wraps git

# Commandline tools
alias apt="aptitude"
alias grep="grep --color=auto"
alias ls="ls --color=auto --group-directories-first"
alias please="sudo"

# Python commandline tools
alias ansible="~/.venvs/ansible/bin/ansible --extra-vars ansible_python_interpreter=/usr/bin/python3"
complete --command ansible --wraps ansible
alias ansible-galaxy="~/.venvs/ansible/bin/ansible-galaxy --extra-vars ansible_python_interpreter=/usr/bin/python3"
complete --command ansible-galaxy --wraps ansible-galaxy
alias ansible-playbook="~/.venvs/ansible/bin/ansible-playbook --extra-vars ansible_python_interpreter=/usr/bin/python3"
alias aws="~/.venvs/awscli/bin/python -m awscli"
alias bpytop="~/.venvs/bpytop/bin/python -m bpytop"
alias glances="~/.venvs/glances/bin/python -m glances"
alias jill="~/.venvs/jill/bin/python -m jill"
alias jupyterlab="~/.venvs/jupyter/bin/python -m jupyter lab"
alias jupytext="~/.venvs/jupytext/bin/jupytext"
alias proselint="~/.venvs/proselint/bin/python -m proselint"
alias speedtest-cli="~/.venvs/speedtest-cli/bin/speedtest-cli"

# Python tooling
alias black="~/.venvs/black/bin/python -m black"
alias flake8="~/.venvs/flake8/bin/python -m flake8"
alias isort="~/.venvs/isort/bin/python -m isort"
alias mypy="~/.venvs/mypy/bin/python -m mypy"
alias piptools="~/.venvs/pip-tools/bin/python -m piptools"
alias pip-compile="~/.venvs/pip-tools/bin/python -m piptools compile"
alias pydocstyle="~/.venvs/pydocstyle/bin/python -m pydocstyle"
alias pytest="~/.venvs/pytest/bin/python -m pytest"
alias safety="~/.venvs/safety/bin/python -m safety"

# Julia commandline tools
alias pluto="julia --project -e 'import Pkg; Pkg.update(\"Pluto\"); import Pluto; Pluto.run()'"
alias jlfmt="julia --startup-file=no -q --compile=min -O0 -e 'import JuliaFormatter; JuliaFormatter.format(\".\", margin = 120, always_for_in = true, whitespace_typedefs = true, whitespace_ops_in_indices = true)'"
