local WindowManager = {}
WindowManager.__index = WindowManager

function WindowManager:new(init_file)
    self = Manager:new("WindowManager", init_file)

    self.window_dragged = false --No other updates when a window is beeing dragged

    self._set_hovered = function(x, y)
        local res_k = nil
        local res_window = nil

        for k, window in pairs(self.children) do
            if window.setHovered(x, y) and not res_k then
                res_k = k
                res_window = window
            else
                window.forceHovered(false)
            end
        end

        return res_k, res_window
    end

    -- At framework mousemoved
    self.mousemoved = function(x, y, dx, dy)
        -- Update hovered if not dragging
        if not self.window_dragged then
            self._set_hovered(x, y)
        end

        -- Update dragged window
        for _, window in pairs(self.children) do
            if window.mousemoved(dx, dy) then 
                self.window_dragged = true
                break -- only 1 window can be dragged
            else
                self.window_dragged = false
            end
        end
    end

    -- At framework mousepressed
    self.mousepressed = function(x, y)
        for k, window in pairs(self.children) do
            if window.hovered and window.setClicked(x, y) then
                self.touch(k)
                break
            end
        end

        return self
    end

    self.dispatch_events = function()
        local events = gui.manager.event.pop_by_receiver(self)

        for k, event in pairs(events) do
            event.args.target.add_event(event)
        end
    end

    -- At framework update
    self.update = function(dt)
        self.dispatch_events()

        for k, window in pairs(self.children) do
            
            window.update(dt)
            
            if window.closed then
                self.remove(k)
            end
        end

        return self
    end

    self.draw = function()
        for i=#self.children, 1, -1 do
            self.children[i].draw()
        end
    end

    -- Transforming config table into instance objects
    self.transform = function(elt)
        --TODO : get instance number by the manager and pass it as new uid
        local window = gui.loader.window.get_unique(elt.static_uid).clone(elt.uid)

        window.parent = self

        --TODO: in Window : les setters qui mettent à jour les children
        if elt.position then
            window.position.x = elt.position.x
            window.position.y = elt.position.y
        end

        if elt.size then
            if elt.size.w then window.size.w = elt.size.w end
            if elt.size.h then window.size.h = elt.size.h end
        end

        return window
    end

    --self.init()

    return self
end

return WindowManager

