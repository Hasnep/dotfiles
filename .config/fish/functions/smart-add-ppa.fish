function smart-add-ppa -a PPA_URL -d "Remove a PPA and re-add it"
    smart-remove-ppa $PPA_URL
    echo "Adding $PPA_URL"
    sudo add-apt-repository -y $PPA_URL
end
