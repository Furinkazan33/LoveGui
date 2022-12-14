
local init = {
    type = "default_init",
    id = "init_windows",

    list = 
    {
        {
            static_uid = "window_normal", uid ="w_normal_1", size = { h = 100 }
        },
        {
            static_uid = "window_normal", uid ="w_normal_2", position = { x = 150, y = 250 } 
        },
        {
            static_uid = "window_no_menu", uid ="w_no_menu_1",
        },
        {
            static_uid = "window_alert", uid ="w_alert_1",
        },
        {
            static_uid = "window_alert", uid ="w_alert_2",
        },
    }
}

return init
