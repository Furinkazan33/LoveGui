local Size = {}
Size.__index = Size


function Size:new(elt)
	self = elt
	
	self.type = "System"
	self.id = "Size"

		
	self.set_zoom = function(coef)
		self.w = self.w * coef
		self.h = self.h * coef
	end

	self.update = function(elt)
		if not elt then return self end
		
		if elt.id == "Size" then 
			self = elt 
			return self
		end
		
		if elt.w then
			self.w = elt.w
		end
		if elt.size.h then
			self.h = elt.h
		end
		
		return self
	end

	self.serialize = function()
		return { w = self.w, h = self.h }
	end

	self.tostring = function()
		return "{ w = " .. self.w .. ", h = " .. self.h .. " }"
	end

	self.clone = function()
		return Size:new(self.w, self.h)
	end

	
	return setmetatable(self, {
		__add = function(s1, s2)
			return Size:new(s1.w + s2.w, s1.h + s2.h)
		end,

		__sub = function(s1, s2)
			return Size:new(s1.w - s2.w, s1.h - s2.h)
		end,

		__mul = function(p1, p2)
			return Size:new(p1.w * p2.w, p1.h * p2.h)
		end,

		__div = function(p1, p2)
			return Size:new(p1.w / p2.w, p1.h / p2.h)
		end,

		__eq = function(p1, p2)
			return p1.w == p2.w and p1.h == p2.h
		end,

		__le = function(p1, p2)
			return p1.w <= p2.w and p1.h <= p2.h
		end,

		__tostring = function()
			return self.type .. "." .. self.id .. self.tostring()
		end
	})
end


return Size