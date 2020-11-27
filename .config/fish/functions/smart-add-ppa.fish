function smart-add-ppa -a "PPA_URL" -d "Remove a PPA and re-add it"
    echo "Removing $PPA_URL"
    sudo add-apt-repository --remove -y $PPA_URL
    echo "Adding $PPA_URL"
    sudo add-apt-repository -y $PPA_URL
end
