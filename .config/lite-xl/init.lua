local core = require "core"
local config = require "core.config"

core.reload_module("colors.gruvbox_dark_medium")

config.ignore_files = {
    "^%.", -- hidden files
    "node_modules", -- npm dependencies
    ".venv", "venv", -- python virtual environments
    "%.log$" -- logfiles
}
