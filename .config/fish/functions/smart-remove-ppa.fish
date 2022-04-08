function smart-remove-ppa -a PPA_URL -d "Remove a PPA"
    echo "Removing $PPA_URL"
    sudo add-apt-repository --remove -y $PPA_URL
end
