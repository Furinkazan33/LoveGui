
--TODO

local debug = {
    type = "config",
    id = "config_debug",

    allowed = {
        {
            type = "System", ids = { "LoveBox2D", "Position", "Size", "Rgb", "Debug", "Context", "Boundary" }
        },
    },

    text = { 
        color = { r=0, g=0, b=0, a=1 },
        font = 18, 
        width = 1,
        newline_inc = 20
    }
}

return debug
