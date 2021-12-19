function youtube-dl --wraps youtube-dl
    if not type --no-functions --query youtube-dl
        pipx install youtube-dl
    end
    command youtube-dl $argv
end
