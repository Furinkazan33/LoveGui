local LoveBox2D = require("LoveBox2D")

local Menu = {}
Menu.__index = Menu

--TODO
function Menu:new(elt)
    self = LoveBox2D:new(elt)
    self.id = "Menu"
    self.menus_height = 0
    self.hidden_h = self.size.h
    self.expanded_h = self.size.h
    self._draw = self.draw
    

    self.draw = function(delta)
        self._draw(delta)

        love.graphics.print(self.name, self.position.x - delta.x, self.position.y - delta.y)

        return self
    end

    self.deserialize = function(elt)
        assert(false, "Impossible to deserialize a Menu")
    end

    self.clone = function()
        assert(false, "Impossible to clone a Menu")
	end


    return self
end

return Menu

