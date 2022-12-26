function wget
    command wget --hsts-file="$XDG_DATA_HOME/wget-hsts" $argv
end
