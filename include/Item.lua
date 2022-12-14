local Item = {}
Item.__index = Item


function Item:new(elt)
    self = LoveBox2D:new(elt)
    self.id = "Item"
    

    self.deserialize = function(elt)
        assert(false, "Impossible to deserialize an Item")
    end

    self.clone = function()
        assert(false, "Impossible to clone an Item")
	end

    return self
end

return Item

