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

# Dotfiles
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
complete --command dotfiles --wraps git

# Aliases
## apt -> aptitude
if type -q aptitude
    alias apt=aptitude
end
## cat -> bat
if type -q fdfind
    alias bat=batcat
end
## docker
if type -q podman
    alias docker=podman
end
## find -> fd
if type -q fdfind
    alias fd=fdfind
end
if type -q fd
    alias find=fd
end
## grep -> rg
if type -q rg
    alias grep=rg
end
## lite -> lite-xl
alias lite=lite-xl
## lock
alias lock="gnome-screensaver-command -l"
## ls -> exa
if type -q exa
    alias ls=exa
end
## sudo
alias please=sudo
if type -q doas
    alias sudo=doas
end

# Pipx aliases
alias asciinema="pipx run asciinema"
alias az="pipx run --spec azure-cli az"
alias bpytop="pipx run bpytop"
alias gdtoolkit="pipx run gdtoolkit"
alias glances="pipx run glances"
alias jill="pipx run jill"
alias proselint="pipx run proselint"
alias speedtest-cli="pipx run speedtest-cli"
alias youtube-dl="pipx run youtube-dl"

# Julia commandline tools
alias pluto="julia --project -e 'import Pkg; Pkg.update(\"Pluto\"); import Pluto; Pluto.run()'"
alias jlfmt="julia --startup-file=no -q --compile=min -O0 -e 'import JuliaFormatter; JuliaFormatter.format(\".\", margin = 120, always_for_in = true, whitespace_typedefs = true, whitespace_ops_in_indices = true)'"
