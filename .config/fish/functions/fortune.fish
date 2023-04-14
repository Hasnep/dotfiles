function fortune
    set fortunes_file $XDG_CONFIG_HOME/fortune/fortunes
    if test -f $fortunes_file
        set fortunes (cat $fortunes_file)
        set n_fortunes (count $fortunes)
        if test $n_fortunes -eq 0
            echo "No fortunes found in '$fortunes_file'."
            return 1
        end
        set random_fortune_index (random 1 $n_fortunes)
        set random_fortune $fortunes[$random_fortune_index]
        echo $random_fortune
        return
    else
        echo "No fortunes file was found at '$fortunes_file'."
        return 1
    end
end
