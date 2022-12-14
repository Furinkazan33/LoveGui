
local config = {
    type = "user_config",
    id = "config_windows",

    list = 
    {
        {
            uid = "window_normal",
            parent = nil, 
            position = { x = 50, y = 50 }, 
            size = { w = 500, h = 200 }, 
            boundary = { infinity = true }, -- { x_min, y_min, x_max, y_max } or { infinity } as default
            visible = true, 
            moveable = true,

            children = { 
                {
                    id = "Menu",
                    uid = "menu1",
                    name = "Fichier",
                    position = { x = 0, y = 0},
                    size = { w = 100, h = 25 }, 
                    moveable = false, 
                    children = {
                        { uid = "i1", position = { x = 0, y = 0 }, size = { w = 100, h = 25} },
                        { uid = "i2", position = { x = 0, y = 0 }, size = { w = 100, h = 25} },
                        { uid = "i3", position = { x = 0, y = 0 }, size = { w = 100, h = 25} },
                        { uid = "i4", position = { x = 0, y = 0 }, size = { w = 100, h = 25} },
                        { uid = "i5", position = { x = 0, y = 0 }, size = { w = 100, h = 25} },
                    }
                },
                {
                    id = "Menu",
                    uid = "menu2",
                    name = "Outils",
                    position = { x = 100, y = 0},
                    size = { w = 100, h = 25 }, 
                    moveable = false, 
                    children = {
                        { uid = "i1", position = { x = 0, y = 0 }, size = { w = 100, h = 25} },
                        { uid = "i2", position = { x = 0, y = 0 }, size = { w = 100, h = 25} },
                    }
                },
                {
                    id = "Button",
                    uid = "b_minimize",
                    position = { x = 425, y = 0 },
                    size = { w = 25, h = 25 }, 
                    moveable = false, 
                    event = "w_minimize"
                },
                {
                    id = "Button",
                    uid = "b_maximize",
                    position = { x = 450, y = 0 },
                    size = { w = 25, h = 25 }, 
                    moveable = false, 
                    event = "w_maximize"
                },
                {
                    id = "Button",
                    uid = "b_close",
                    position = { x = 475, y = 0 },
                    size = { w = 25, h = 25 }, 
                    moveable = false, 
                    event = "w_close"
                },
                {
                    id = "TopBar",
                    uid = "topbar",
                    name = "window_normal",
                    position = {
                        x = 200, y = 0
                    },
                    size = {
                        w = 225, h = 25
                    },
                    moveable = false
                }
            },
        },
        {
            uid = "window_no_menu",
            parent = nil, 
            position = { x = 500, y = 500 }, 
            size = { w = 800, h = 400 }, 
            visible = true, 
            moveable = true,

            children = {
                {
                    id = "Button",
                    uid = "b_minimize",
                    position = { x = 725, y = 0 },
                    size = { w = 25, h = 25 }, 
                    moveable = false, 
                    event = "w_minimize"
                },
                {
                    id = "Button",
                    uid = "b_maximize",
                    position = { x = 750, y = 0 },
                    size = { w = 25, h = 25 }, 
                    moveable = false, 
                    event = "w_maximize"
                },
                {
                    id = "Button",
                    uid = "b_close",
                    position = { x = 775, y = 0 },
                    size = { w = 25, h = 25 }, 
                    moveable = false, 
                    event = "w_close"
                },
                {
                    id = "TopBar",
                    uid = "topbar",
                    name = "window_no_menu",
                    position = {
                        x = 0, y = 0
                    },
                    size = {
                        w = 725, h = 25
                    },
                    moveable = false
                },
            },
        },
        {
            uid = "window_alert",
            parent = nil, 
            position = { x = 500, y = 500 }, 
            size = { w = 200, h = 200 }, 
            visible = true, 
            moveable = true,

            children = {
                {
                    id = "Button",
                    uid = "b_close",
                    position = { x = 175, y = 0 },
                    size = { w = 25, h = 25 }, 
                    moveable = false, 
                    event = "w_close"
                },
                {
                    id = "TopBar",
                    uid = "topbar",
                    name = "window_alert",
                    position = {
                        x = 0, y = 0
                    },
                    size = {
                        w = 175, h = 25
                    },
                    moveable = false
                },
            },
        },
    }
}

return config
