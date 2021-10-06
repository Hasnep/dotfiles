-- Adapted from Brian Reilly's Sublime Text Gruvbox theme
-- See here for more info: https://github.com/Briles/gruvbox

local style = require "core.style"
local common = require "core.common"

local colours = {
    bg = { common.color "#282828" },
    bg0 = { common.color "#282828" },
    bg1 = { common.color "#3C3836" },
    bg2 = { common.color "#504945" },
    bg3 = { common.color "#665C54" },
    bg4 = { common.color "#7C6F64" },
    gray = { common.color "#928374" },
    fg = { common.color "#EBDBB2" },
    fg0 = { common.color "#FBF1C7" },
    fg1 = { common.color "#EBDBB2" },
    fg2 = { common.color "#D5C4A1" },
    fg3 = { common.color "#BDAE93" },
    fg4 = { common.color "#A89984" },
    red = { common.color "#FB4934" },
    red1 = { common.color "#CC241D" },
    green = { common.color "#B8BB26" },
    green1 = { common.color "#98971A" },
    yellow = { common.color "#FABD2F" },
    yellow1 = { common.color "#D79921" },
    blue = { common.color "#83A598" },
    blue1 = { common.color "#458588" },
    purple = { common.color "#D3869B" },
    purple1 = { common.color "#B16286" },
    aqua = { common.color "#8EC07C" },
    aqua1 = { common.color "#689D6A" },
    orange = { common.color "#FE8019" },
    orange1 = { common.color "#D65D0E" },
} 

style.background = colours.bg
style.background2 = colours.bg1
style.background3 = colours.bg2
style.text = colours.fg
style.caret = colours.fg4
style.accent = colours.yellow
style.dim = colours.gray  
style.divider = colours.bg1 
style.selection = colours.bg1
style.line_number = colours.gray
style.line_number2 = colours.aqua
style.line_highlight = colours.bg1  
style.scrollbar = colours.bg1 
style.scrollbar2 = colours.bg2  

style.syntax["normal"] = colours.fg
style.syntax["symbol"] = colours.fg
style.syntax["comment"] = colours.gray
style.syntax["keyword"] = colours.red
style.syntax["keyword2"] = colours.blue
style.syntax["number"] = colours.purple
style.syntax["literal"] = colours.purple
style.syntax["string"] = colours.green   
style.syntax["operator"] = colours.aqua
style.syntax["function"] = colours.aqua
