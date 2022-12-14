
local Gui = require("init")


function love.load()
    print()

    gui = Gui:new()    
    modules = gui.init()
    gui.debug(true)

end


function love.update(dt)
    
    gui.update()

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
