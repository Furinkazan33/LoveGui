local Rgb = {}
Rgb.__index = Rgb

function Rgb:new(elt)
	self = elt
	self.type = "System"
	self.id = "Rgb"
	self.uid = elt.uid
	self.a = self.a or 1
	self.c = self.c or 1
		
	self.alpha = function(percent)
		local rgb = self.clone()
		
		if percent then
			rgb.a = percent
		end
		
		return rgb
	end

	self.serialize = function()
		return { 
			uid = self.uid,
			r = self.r,
			g = self.g,
			b = self.b,
			a = self.a,
			c = self.c,
		}
	end
	
	self.deserialize = function(elt)
		return Rgb:new(elt)
	end
	
	self.clone = function()
		return Rgb:new(self.serialize())
	end

	self.tostring = function()
		return "[" .. self.uid .. ", " .. self.r .. "," .. self.g .. "," .. self.b .. "," .. self.a .. "," .. self.c .."]"
	end
	
	self.concentration = function(percent)
		local rgb = self.clone()
		
		if percent then
			self.c = percent
			
			if rgb.r ~= 0 then rgb.r = percent end
			if rgb.g ~= 0 then rgb.g = percent end
			if rgb.b ~= 0 then rgb.b = percent end
		end
		
		return rgb
	end

	return setmetatable(self, {
		__eq = function(c1, c2)
			return c1.r == c2.r and 
					c1.g == c2.g and 
					c1.b == c2.b and 
					c1.a == c2.a
		end,

		__tostring = function()
			return self.type .. "." .. self.id .. self.tostring()
		end,
	})
end

return Rgb
