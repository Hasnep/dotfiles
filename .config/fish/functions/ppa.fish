function ppa --argument action --argument ppa_url --description "Add or remove a ppa"
    function ppa-remove --argument ppa_url
        echo "Removing $ppa_url"
        sudo add-apt-repository --remove -y $ppa_url
    end

    function ppa-add --argument ppa_url
        ppa-remove $ppa_url
        echo "Adding $ppa_url"
        sudo add-apt-repository -y $ppa_url
    end

    switch $action
        case add
            if test -n "$ppa_url"
                ppa-add $ppa_url
            else
                echo "PPA not specified."
            end
        case remove
            if not test -n "$ppa_url"
                set ppa_url (apt-add-repository --list | fzf)
            end
            ppa-remove $ppa_url
        case list
            apt-add-repository --list | sort
        case '*'
            echo "Action must be either `add`, `remove` or `list`."
            return 1
    end
end
