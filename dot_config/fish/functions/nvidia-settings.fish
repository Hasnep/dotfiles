if type --query --no-functions nvidia-settings
    function nvidia-settings
        nvidia-settings --config="$XDG_CONFIG_HOME/nvidia/settings" $ARGV
    end
end
