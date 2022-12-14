
local config = {
    type = "config",
    id = "config_modules",

    list = {},
    n = 0,
}

config.add = function (elt)
    config.n = config.n + 1
    config.list[config.n] = elt
end


config.add({ uid = "WindowFactory", path = "include/WindowFactory", type = "factory", name = "window", new = false, init = false })
config.add({ uid = "EventFactory", path = "EventFactory", type = "factory", name = "event",            new = false, init = false })
config.add({ uid = "ContextFactory", path = "ContextFactory", type = "factory", name = "context",      new = false, init = false })

-- Keep this order for the loaders
config.add({ uid = "ColorLoader", path = "ColorLoader", type = "loader", name = "color",               new = true, new_file = "config/config_colors", init = true })
config.add({ uid = "ContextLoader", path = "ContextLoader", type = "loader", name = "context",         new = true, new_file = "config/config_context", init = true })
config.add({ uid = "EventLoader", path = "EventLoader", type = "loader", name = "event",               new = true, new_file = "config/config_events", init = true })
config.add({ uid = "WindowLoader", path = "include/WindowLoader", type = "loader", name = "window",    new = true, new_file = "config/config_windows", init = true })

config.add({ uid = "WindowManager", path = "include/WindowManager", type = "manager", name = "window", new = true, new_file = "init/init_windows", init = true })
config.add({ uid = "EventManager", path = "include/EventManager", type = "manager", name = "event",    new = true, init = true })

-- Debug printing on canvas
config.add({ uid = "LoveDebug", path = "LoveDebug", type = "global", name = "debug",    new = true, new_file = "config/config_debug", init = false })

-- Simple scaler module (method set_zoom to implement in each component)
config.add({ uid = "LoveZoom", path = "LoveZoom", type = "global", name = "zoom",    new = true, new_file = "config/config_resolution", init = false })



return config
