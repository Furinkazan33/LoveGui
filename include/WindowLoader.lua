local WindowLoader = {}
WindowLoader.__index = WindowLoader

-- TODO All possible dispositions
WindowLoader.canvas = { 
    {   uid = "border-eight",
        { uid = "window-topleft",  },
        { uid = "window-top" },
        { uid = "window-topright" },
        { uid = "window-bottomeft" },
        { uid = "window-bottom" },
        { uid = "window-bottomright" },
        { uid = "window-left" },
        { uid = "window-right" },
    },
    {   uid = "border-four",
        { uid = "window-top" },
        { uid = "window-bottom" },
        { uid = "window-left" },
        { uid = "window-right" },
    },
    {   uid = "four",
        { uid = "window-topleft" },
        { uid = "window-bottomleft" },
        { uid = "window-topright" },
        { uid = "window-bottomright" },
    },
    {   uid = "three-left",
        { uid = "window-top-left" },
        { uid = "window-bottom-left" },
        { uid = "window-right" },
    },
    {   uid = "three-right",
        { uid = "window-top-right" },
        { uid = "window-bottom-right" },
        { uid = "window-left" },
    },
    {   uid = "two_h",
        { uid = "window-top" },
        { uid = "window-bottom" },
    },
    {   uid = "two_v",
        { uid = "window-left" },
        { uid = "window-right" },
    },
}

function WindowLoader:new(config_file)
    self = Manager:new("WindowLoader", config_file)
    
    -- Transforming config table into instance objects
    self.transform = function(elt)
        elt.parent = self.uid
        return modules.factory.window.window.deserialize(elt)
    end

    --self.init()


    return self
end

return WindowLoader

