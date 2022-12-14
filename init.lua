-- TODO: 
-- - themes
-- - save configs in user folder
-- - config manager to manage default configs and user configs
-- - utiliser les canvas
-- - sticky windows

local Gui = {}
Gui.__index = Gui

function Gui:new(name)
    self = {
        modules = {
            factory = {
                window = require("include/WindowFactory"),
                event = require("EventFactory"),
                context = require("ContextFactory"),
            },
            loader = {},
            manager = {},
        },
    }

    self.modules.loader.color = require("ColorLoader"):new("config/config_colors")
    self.modules.loader.context = require("ContextLoader"):new("config/config_context")
    self.modules.loader.event = require("EventLoader"):new("config/config_events")
    self.modules.loader.window = require("include/WindowLoader"):new("config/config_windows")
    
    self.modules.manager.window = require("include/WindowManager"):new("init/init_windows")
    self.modules.manager.event = require("include/EventManager"):new()



    -- Initializing modules based on the config file
    -- modules.factory : Components factories
    -- modules.loader : Default static components loaded at startup
    -- modules.manager : Dynamic components created at runtime (clones of defaults loaded components)

    self.init = function()
        self.modules.loader.color:init()
        self.modules.loader.context.init()
        self.modules.loader.event:init() 
        self.modules.loader.window:init()
    
        self.modules.manager.window:init()
        self.modules.manager.event:init()

        return self.modules
    end

    self.debug = function(bool)
        self.modules.global.debug.set(bool)
    end
    
    self.update = function()
        for _, manager in pairs(self.modules.manager) do
            manager.update()
        end
    end

    self.set_zoom = function(coef)
        self.modules.manager.window.set_zoom(coef)
    end

    self.mousemoved = function(x, y, dx, dy, istouch)
        self.modules.manager.window.mousemoved(x, y, dx, dy)
    end

    self.mousepressed = function(x, y, button, istouch, presses)
        if button == 1 then
            self.modules.manager.window.mousepressed(x, y)
        end
    end

    self.draw = function()
        self.modules.manager.window.draw()
    end

    return self
end

return Gui
