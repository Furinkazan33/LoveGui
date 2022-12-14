
local config = {
    type = "user_config",
    id = "config_events",

    -- This list contains all possible events that are loaded via the event loader
    -- Every required args are given
    -- Additionnals args can be added later in the loader, manager, factory or dispatcher 
    -- The dispatcher for example, adds the "receiver" argument, so that every manager 
    -- knows which event to treat
    list = 
    {
        {
            uid = "all_message_to", args = { sender = "", content = "" }
        },
        {
            uid = "message_to", args = { sender = "", content = "", target = "" }
        },
        {
            uid = "s_debug", args = { sender = "", content = "" }
        },
        {
            uid = "s_info", args = { sender = "", content = "" }
        },
        {
            uid = "s_error", args = { sender = "", content = "" }
        },
        {
            uid = "w_minimize", args = { sender = "", target = "" }
        },
        {
            uid = "w_maximize", args = { sender = "", target = "" }
        },
        {
            uid = "w_close", args = { sender = "", target = "" }
        },
        {
            uid = "w_save", args = { sender = "", target = "" }
        },
        {
            uid = "w_is_saving", args = { sender = "", target = "" }
        },
        {
            uid = "w_restore", args = { sender = "", target = "" }
        },
        {
            uid = "w_is_restoring", args = { sender = "", target = "" }
        },
        {
            uid = "w_open", args = { sender = "", receiver = "" }
        },
        {
            uid = "w_is_opening", args = { sender = "", receiver = "" }
        },
        {
            uid = "w_move", args = { sender = "", position = "", target = "" }
        },
        {
            uid = "w_move_smooth", args = { sender = "", position = "", target = "" }
        },
        {
            uid = "w_moveable", args = { sender = "", value = "", target = "" }
        },
        {
            uid = "w_reorg", args = { sender = "", setup = "", target = "" }
        },
        {
            uid = "w_is_hovered", args = { sender = "", target = "" }
        },
        {
            uid = "w_is_clicked", args = { sender = "", target = "" }
        },
        {
            uid = "w_is_moving", args = { sender = "", dx = "", dy = "", target = "" }
        },
        {
            uid = "w_is_moving_smoothly", args = { sender = "", dx = "", dy = "", target = "" }
        },
        {
            uid = "w_is_dragging_start", args = { sender = "", position = "", target = "" }
        },
        {
            uid = "w_is_dragging", args = { sender = "", position = "", target = "" }
        },
        {
            uid = "w_is_dragging_end", args = { sender = "", position = "", target = "" }
        },
        {
            uid = "w_is_closing", args = { sender = "", target = "" }
        },
        {
            uid = "w_is_closed", args = { sender = "", target = "" }
        },
        {
            uid = "w_is_opening", args = { sender = "", target = "" }
        },
        {
            uid = "w_is_opened", args = { sender = "", target = "" }
        },
    }
}

return config
