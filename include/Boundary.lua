local Boundary = {}
Boundary.__index = Boundary


function Boundary:Infinity()
	return Boundary:new({ infinity = true })
end

function Boundary:new(elt)
	if not elt.infinity then
		assert(elt.x_min, "Boundary:new - x_min required")
		assert(elt.y_min, "Boundary:new - y_min required")
		assert(elt.x_max, "Boundary:new - x_max required")
		assert(elt.y_max, "Boundary:new - y_max required")
	end
	
	self = {
		type = "System", 
		id = "Boundary",

		x_min = elt.x_min,
		y_min = elt.y_min,
		x_max = elt.x_max,
		y_max = elt.y_max,
		infinity = elt.infinity or false,

		set_zoom = function(coef)
			if not self.infinity then
				self.x_min = self.x_min * coef
				self.y_min = self.y_min * coef
				self.x_max = self.x_max * coef
				self.y_max = self.y_max * coef
			end
		end,

		serialize = function()
			return { 
				x_min = self.x_min, 
				y_min = self.y_min, 
				x_max = self.x_max, 
				y_max = self.y_max,
				infinity = self.infinity,
			}
		end,
		
		deserialize = function(elt)
			return Boundary:new(elt)
		end,
		
		tostring = function()
			if self.infinity == true then
				return "{ infinity }"
			end
			return "{ x_min = " .. self.x_min .. ", y_min = " .. self.y_min ..
					", x_max = " .. self.x_max .. ", y_max = " .. self.y_max .. " }"
		end,

		clone = function()
			return self.deserialize(self.serialize())
		end,
	}

	return setmetatable(self, {

		__tostring = function()
			return 	self.type .. "." .. self.id .. self.tostring()
		end,

	})

end



return Boundary
