# Activate a Python venv in ~/.venvs/<name of venv>
function activate {
    source ~/.venvs/${1:?"Specify the venv"}/bin/activate
}
