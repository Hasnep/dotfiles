function lock
    if type -q gnome-screensaver-command
        gnome-screensaver-command -l
    end
    if type -q xflock4
        xflock4
    end
end
