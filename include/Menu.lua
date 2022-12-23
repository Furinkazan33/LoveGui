local Menu = {}
Menu.__index = Menu

--TODO
function Menu:new(elt)
    self = LoveBox2D:new(elt)
    self.id = "Menu"
    self.menus_height = 0
    self.hidden_h = self.size.h
    self.expanded_h = self.size.h

    self.deserialize = function(elt)
        assert(false, "Impossible to deserialize a Menu")
    end

    self.clone = function()
        assert(false, "Impossible to clone a Menu")
	end

    return self
end

return Menu

