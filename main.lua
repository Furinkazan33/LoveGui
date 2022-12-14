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
LoveDebug = require("include/LoveDebug"):new("config/config_debug")

Gui = require("Gui")


function love.load()
    print()

    gui = Gui:new()
    modules = gui.modules
    gui.init()

    LoveDebug.set(true)

end


function love.update(dt)
    
    gui.update(dt)

end


function love.mousemoved(x, y, dx, dy, istouch)
    gui.mousemoved(x, y, dx, dy)
end

function love.mousepressed(x, y, button, istouch, presses)
    gui.mousepressed(x, y)
end

function love.draw()
    love.graphics.setBackgroundColor(0.3, 0.5, 0.5, 1)

    gui.draw()
end


function love.quit()
    

end
