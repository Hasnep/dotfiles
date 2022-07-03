function speedtest-cli --wraps speedtest-cli
    if not type --no-functions --query speedtest-cli
        pipx install speedtest-cli
    end
    command speedtest-cli $argv
end
