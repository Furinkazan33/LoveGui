
local TopBar = {}
TopBar.__index = TopBar


function TopBar:new(elt)
    self = LoveBox2D:new(elt)
    self.id = "TopBar"

    self.resize = function(dx)
        self.size.w = self.size.w + dx

        return self
    end

    self.deserialize = function(elt)
        assert(false, "Impossible to deserialize a TopBar")
    end

    self.clone = function()
        assert(false, "Impossible to clone a TopBar")
	end

    return self
end

return TopBar

