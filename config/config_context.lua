
local config = {
    type = "config",
    id = "config_context",

    list = {
        window = {
            uid = "window",
            fill = { uid = "grey", concentration = 0.8, alpha = 1 }, 
            line = { uid = "blue", concentration = 0.4, alpha = 1 },
            line_width = 1,

            hovered = {
                fill = { uid = "grey", concentration = 0.8, alpha = 1 }, 
                line = { uid = "blue", concentration = 0.4, alpha = 1 },
                line_width = 1,
            },
            dragged = {
                fill = { uid = "grey", concentration = 0.8, alpha = 0.1 }, 
                line = { uid = "blue", concentration = 0.4, alpha = 0.5 },
                line_width = 1,
            },
            text = {
                uid = "white", concentration = 1, alpha = 1
            }
        },
        topbar = {
            uid = "topbar",
            fill = { uid = "blue", concentration = 0.8, alpha = 1 }, 
            line = { uid = "grey", concentration = 0.4, alpha = 1 },
            line_width = 1,

            hovered = {
                fill = { uid = "blue", concentration = 1, alpha = 1 }, 
                line = { uid = "grey", concentration = 0.6, alpha = 1 },
                line_width = 1,
            },
            dragged = {
                fill = { uid = "blue", concentration = 0.8, alpha = 0.1 }, 
                line = { uid = "grey", concentration = 0.4, alpha = 0.5 },
                line_width = 1,
            },
            text = {
                uid = "white", concentration = 1, alpha = 1
            }
        },
        button = {
            uid = "button",
            fill = { uid = "red", concentration = 0.6, alpha = 1 }, 
            line = { uid = "grey", concentration = 0.4, alpha = 1 },
            line_width = 1,

            hovered = {
                fill = { uid = "red", concentration = 0.4, alpha = 1 }, 
                line = { uid = "grey", concentration = 0.2, alpha = 1 },
                line_width = 1,
            },
            dragged = {
                fill = { uid = "red", concentration = 0.6, alpha = 0.1 }, 
                line = { uid = "grey", concentration = 0.4, alpha = 0.5 },
                line_width = 1,
            },
            text = {
                uid = "white", concentration = 1, alpha = 1
            }
        },
        menu = {
            uid = "menu",
            fill = { uid = "grey", concentration = 0.4, alpha = 1 }, 
            line = { uid = "grey", concentration = 0.1, alpha = 1 },
            line_width = 1,

            hovered = {
                fill = { uid = "grey", concentration = 0.6, alpha = 1 }, 
                line = { uid = "grey", concentration = 0.4, alpha = 1 },
                line_width = 1,
            },
            dragged = {
                fill = { uid = "grey", concentration = 0.4, alpha = 0.1 }, 
                line = { uid = "grey", concentration = 0.1, alpha = 0.5 },
                line_width = 1,
            },
            text = {
                uid = "white", concentration = 1, alpha = 1
            }
        }
    }
}


return config
