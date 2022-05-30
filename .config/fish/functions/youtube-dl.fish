function youtube-dl --wraps youtube-dl
    if type --no-functions --query youtube-dl
        # Make sure youtube-dl is always on the latest version
        pipx upgrade youtube-dl
    else
        pipx install youtube-dl
    end
    command youtube-dl $argv
end
