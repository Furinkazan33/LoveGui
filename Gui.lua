-- TODO: 
-- - themes
-- - save configs in user folder
-- - config manager to manage default configs and user configs
-- - utiliser les canvas
-- - sticky windows
table = require("include/table+")
LoveBox2D = require("include/LoveBox2D")
Rgb = require("include/Rgb")
Context = require("include/Context")
Event = require("include/Event")
Window = require("include/Window")
TopBar = require("include/TopBar")
Button = require("include/Button")
Menu = require("include/Menu")
Item = require("include/Item")
Manager = require("include/Manager")

local Gui = {}
Gui.__index = Gui


-- factory : Components factories
-- loader : Default static components loaded at startup
-- manager : Dynamic components created at runtime (clones of defaults loaded components)
function Gui:new(name)
    self = {
        factory = {
            window = require("include/WindowFactory"),
            event = require("include/EventFactory"),
            context = require("include/ContextFactory"),
        },
        loader = {},
        manager = {},
    }

    self.loader.color = require("include/ColorLoader"):new("config/config_colors")
    self.loader.context = require("include/ContextLoader"):new("config/config_context")
    self.loader.event = require("include/EventLoader"):new("config/config_events")
    self.loader.window = require("include/WindowLoader"):new("config/config_windows")
    
    self.manager.window = require("include/WindowManager"):new("init/init_windows")
    self.manager.event = require("include/EventManager"):new()

    self.init = function()
        self.loader.color:init()
        self.loader.context.init()
        self.loader.event:init() 
        self.loader.window:init()
    
        self.manager.window:init()
        self.manager.event:init()

        return self
    end
        
    self.update = function(dt)
        for _, manager in pairs(self.manager) do
            manager.update(dt)
        end
    end

    self.set_zoom = function(coef)
        self.manager.window.set_zoom(coef)
    end

    self.mousemoved = function(x, y, dx, dy, istouch)
        self.manager.window.mousemoved(x, y, dx, dy)
    end

    self.mousepressed = function(x, y, button, istouch, presses)
        if button == 1 then
            self.manager.window.mousepressed(x, y)
        end
    end

    self.draw = function()
        self.manager.window.draw()
    end

    return self
end

return Gui
