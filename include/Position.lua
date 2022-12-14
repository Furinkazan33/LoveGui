local Position = {}
Position.__index = Position

function Position:new(elt)
	self = elt
	
	self.type = "System" 
	self.id = "Position"

		
	self.set_zoom = function(coef)
		self.x = self.x * coef
		self.y = self.y * coef
	end

	self.update = function(elt)
		if not elt then return self end
		
		if elt.id == "Position" then 
			self = elt 
			return self
		end
		
		if elt.x then
			self.x = elt.x
		end
		if elt.y then
			self.y = elt.y
		end
		
		return self
	end

	self.serialize = function()
		return { x = self.x, y = self.y }
	end
	
	self.deserialize = function(elt)
		return Position:new(elt)
	end
	
	self.tostring = function()
		return "{ x = " .. self.x .. ", y = " .. self.y .. " }"
	end
	
	self.clone = function()
		return self.deserialize(self.serialize())
	end

	self.add = function(delta)
		self.x = self.x + delta.x
		self.y = self.y + delta.y
		
		return self
	end

	self.sub = function(delta)
		self.x = self.x - delta.x
		self.y = self.y - delta.y
		
		return self
	end

	return setmetatable(self, {
		__add = function(p1, p2)
			return Position:new(p1.x + p2.x, p1.y + p2.y)
		end,

		__sub = function(p1, p2)
			return Position:new(p1.x - p2.x, p1.y - p2.y)
		end,

		__eq = function(p1, p2)
			return p1.x == p2.x and p1.y == p2.y
		end,

		__le = function(p1, p2)
			return p1.x <= p2.x and p1.y <= p2.y
		end,

		__tostring = function()
			return 	self.type .. "." .. self.id .. self.tostring()
		end,
	})
end

return Position
