function speedtest --wraps speedtest
    if not type --no-functions --query speedtest
        pipx install speedtest-cli
    end
    command speedtest $argv
end
