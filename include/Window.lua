
local Window = {}
Window.__index = Window


function Window:new(elt)
    self = LoveBox2D:new(elt)
    self._draw = self.draw
    self.id = "Window"
    self.events = {}
    self.minimize = false
    self.maximize = false
    self.closed = false
   

    self.get_size_from_children = function(id, size)
        local children = self.get_by_id(id)
        local result = 0

        for _, child in pairs(children) do
            result = result + child.size[size]
        end

        return result
    end

    self.adjust_buttons_position = function(dx)
        local buttons = self.get_by_id("Button")

        for k, button in pairs(buttons) do
            button.position.x = button.position.x + dx
        end

        return self
    end

    self.resize = function(dx, dy, min_width, min_height)
        local new_w = self.size.w + dx
        local new_h = self.size.h + dy

        if new_w <= min_width then new_w = min_width end
        if new_h <= min_height then new_h = min_height end

        -- Real delta resize
        local delta = { x = new_w - self.size.w, y = new_h - self.size.h }

        self.size.w = new_w
        self.size.h = new_h

        return delta.x, delta.y
    end

    self.resize_w = function(dx, dy)
        local min_width = self.get_size_from_children("Menu", "w") + self.get_size_from_children("Button", "w")
        local min_height = self.get_size_from_children("TopBar", "h")

        dx, dy = self.resize(dx, dy, min_width, min_height)

        self.get_topbar().resize(dx)
        self.adjust_buttons_position(dx)

        return self
    end

    self.mousemoved = function(dx, dy)
        local topbar = self.get_topbar()

        if not topbar then return false end

        if topbar.clicked then
            self.setDragged(true)
            self.position.x = self.position.x + dx
            self.position.y = self.position.y + dy
        else
            self.setDragged(false)   
        end

        return self.dragged
    end

    self.get_topbar = function()
        local topbar, n = self.get_by_id("TopBar")
        
        if n >= 1 then return topbar[1] end

        return nil
    end

    self.add_event = function(e)
        table.insert(self.events, e)

        return self
    end

    self.update = function()
        self.setClickedAndRelease()

        for _, child in pairs(self.children) do
            if child.update then child.update() end
        end

        if not self.closed then
            for _, e in pairs(self.events) do
                if e.uid == "w_minimize" then 
                    self.minimize = true
            
                elseif e.uid == "w_maximize" then 
                    self.maximize = true

                elseif e.uid == "w_close" then 
                    self.closed = true
                end
            end
        end

        return self
    end

    self.print_title = function(delta)
        local topbar = self.get_topbar()

        if not topbar then return false end

        love.graphics.setColor(self.context.text.r, self.context.text.g, self.context.text.b, self.context.text.a)
        
        if delta then
            love.graphics.print(topbar.name, self.position.x + topbar.position.x - delta.x + topbar.size.w/3, self.position.y + topbar.position.y - delta.y)
        else
            love.graphics.print(topbar.name, self.position.x + topbar.position.x + topbar.size.w/3, self.position.y + topbar.position.y)
        end
    end

    self.draw = function(delta)
        -- Normal drawing
        self._draw(delta)

        -- Printing window title
        self.print_title(delta)

        return self
    end

    self.deserialize = function(elt)
        return modules.factory.window.window.deserialize(elt)
    end

    self.clone = function(new_uid)
        assert(new_uid, "Window.clone - new uid required")

        local elt = self.serialize()
        elt.uid = new_uid

        return self.deserialize(elt)
	end

    return self
end

return Window