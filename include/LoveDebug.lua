local LoveDebug = {}
LoveDebug.__index = LoveDebug

function LoveDebug:new(config, position)
	local config = require(config)
	self = {
		type = "System",
		id = "LoveDebug",

		enable = false,
		position = { x = 0, y = 0 },
		position_start = position or { x = 0, y = 0 },
		allowed = config.allowed,
		text = config.text,
	}

	self.set = function(bool)
		self.enable = bool
		
		return self
	end

	self.set_zoom = function(coef)
		self.text.width = self.text.width * coef
		self.text.newline_inc = self.text.newline_inc * coef
		self.position_start.x = self.position_start.x * coef
		self.position_start.y = self.position_start.y * coef
	end

	self.add = function(name, variable)
		self.allowed[name] = variable
	end
	
	self.print_allowed = function()
		if not self.enable then return end

		self.position.x = self.position_start.x
		self.position.y = self.position_start.y

		love.graphics.setLineWidth(self.text.width)
		love.graphics.setColor(self.text.color.r, self.text.color.g, self.text.color.b, self.text.color.a)

		for k, v in pairs(self.allowed) do
			if type(v) == "table" then
				-- table name
				self.simple_print(k, "")
				
				for k2, v2 in pairs(v) do
					self.simple_print(k2, v2)
				end
			else
				self.simple_print(k, v)
			end
		end
	end

	self.simple_print = function(k, v)
		if type(v) ~= "function" then
			
			love.graphics.print(tostring(k) .. " = " .. tostring(v), self.position.x, self.position.y)

			-- newline
			self.position.y = self.position.y + self.text.newline_inc
		end
	end
	
	return setmetatable(self, {
		__tostring = function()
			return "[" .. self.type .. "." .. self.id .. "]"
		end,
	})
end

return LoveDebug
