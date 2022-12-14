
local LoveBox2D = require("LoveBox2D")

local MenuBar = {}
MenuBar.__index = MenuBar

--TODO
function MenuBar:new(elt)
    self = LoveBox2D:new(elt)
    self.id = "MenuBar"
    self.disposition = modules.loader.window.disposition.left
        
    
    self.add_menu = function(menu)
        
        self.children.add(menu)

        return self
    end

    self.add_link = function(link)
        

        self.children.add(link)

        return self
    end

    self.serialize = function()
        local elt = {
            uid = self.uid, 
            parent = self.parent.uid,
            name = self.name,
            position = self.position.serialize(),
            size = self.size.serialize(),
            moveable = self.moveable,
            children = {},
        }

        for k, child in pairs(self.children) do
            local serialized = child.serialize()

            if child.id == "Item" then
                table.insert(elt.children, serialized)
            else
                assert(false, "MenuBar.serialize - Child object unknown : " .. child.id)
			end
        end

        return elt
    end


    self.clone = function()
		local elt = self.serialize()
		elt.parent = self.parent
		
		return MenuBar:new(elt)
	end

    

    return self
end

return MenuBar

