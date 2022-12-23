
local debug = {
    type = "config",
    id = "config_debug",

    -- Allowed variables
    allowed = {
        name_to_print = variable_name,
        _G = _G,
    },

    text = { 
        color = { r=0, g=0, b=0, a=1 },
        font = 18, 
        width = 2,
        newline_inc = 20
    }
}




return debug
