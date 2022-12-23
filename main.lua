local LoveDebug = require("include/LoveDebug"):new("config/config_debug", { x = 10, y = 10 })
local LoveZoom = require("include/LoveZoom"):new("config/config_resolution")
local simpleZoom = require("include/Zoom"):new("config/config_zoom")
local Gui = require("Gui")


function love.load()
    print()

    gui = Gui:new()
    gui.init()

    LoveDebug.set(true)
    LoveDebug.add("windows", gui.manager.window.children)

    LoveZoom.register(gui.manager.window)
    simpleZoom.register(gui.manager.window)

    LoveZoom.register(LoveDebug)

    -- Loading the first resolution
    LoveZoom.set_zoom(1)

    -- Loading the first zoom
    simpleZoom.set_zoom(1)
end


function love.update(dt)
    -- Toggle resolutions
    if love.keyboard.isDown('f') then 
        love.timer.sleep(0.5)
        LoveZoom.next()
    end

    gui.update(dt)
end

function love.wheelmoved(x, y)
    if y > 0 then
        simpleZoom.next()

    elseif y < 0 then
        simpleZoom.previous()
    end
end


function love.mousemoved(x, y, dx, dy, istouch)
    gui.mousemoved(x, y, dx, dy, istouch)
end

function love.mousepressed(x, y, button, istouch, presses)
    gui.mousepressed(x, y, button, istouch, presses)
end

function love.draw()
    love.graphics.setBackgroundColor(0.3, 0.5, 0.5, 1)

    gui.draw()

    
    LoveDebug.print_allowed(50, 50)
end


function love.quit()
    

end
