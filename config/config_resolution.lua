
local config = {
    type = "config",
    id = "config_resolution",

    list = {
        {--1920x1080
            w = 1920, 
            h = 1080,
            coef = 1.0,
            --font = 18,
        },

        {--1280x720
            w = 1280, 
            h = 720,
            coef = 1280 / 1920,
            --font = 14,
        },

        {--854x480
            w = 854, 
            h = 480,
            coef = 854 / 1920,
            --font = 8,
        },

        {--640x360
            w = 640, 
            h = 360,
            coef = 640 / 1920,
            --font = 6,
        },
    },
    res_list = { "1920x1080", "1280x720", "854x480", "640x360"
    }
}


return config
