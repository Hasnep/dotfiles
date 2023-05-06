function push --wraps=git
    command git push --set-upstream (command git config --get remote.origin.url)
end
