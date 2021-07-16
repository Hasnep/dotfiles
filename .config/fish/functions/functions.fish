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
alias venv-tools="python3 ~/.local/bin/venv-tools.py"
alias venv-auto="python3 ~/.local/bin/venv-tools.py auto"
alias venv-create="python3 ~/.local/bin/venv-tools.py create"

# Dotfiles
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
complete --command dotfiles --wraps git

# Aliases

alias apt=aptitude
alias apt="command apt"

alias bat=batcat

alias fd=fdfind
alias find=fdfind
alias find="command find"

alias grep=rg
alias grep="command grep"

alias ls=exa
alias ls="command ls"

alias please=sudo

# Pipx aliases
alias asciinema=pipx run asciinema
alias awscli=pipx run awscli
alias bpytop=pipx run bpytop
alias gdtoolkit=pipx run gdtoolkit
alias glances=pipx run glances
alias jill=pipx run jill
alias proselint=pipx run proselint
alias speedtest-cli=pipx run speedtest-cli
alias youtube-dl=pipx run youtube-dl


# Julia commandline tools
alias pluto="julia --project -e 'import Pkg; Pkg.update(\"Pluto\"); import Pluto; Pluto.run()'"
alias jlfmt="julia --startup-file=no -q --compile=min -O0 -e 'import JuliaFormatter; JuliaFormatter.format(\".\", margin = 120, always_for_in = true, whitespace_typedefs = true, whitespace_ops_in_indices = true)'"
