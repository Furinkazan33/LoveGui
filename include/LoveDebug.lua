local LoveDebug = {}
LoveDebug.__index = LoveDebug

function LoveDebug:new(config, position)
	local config = require(config)
	self = {
		type = "System",
		id = "LoveDebug",

		enable = false,
		position = position or { x = 0, y = 0 },
		allowed = config.allowed,
		allowed_variables = {},
		text = config.text,

		position_set = false
	}

	self.set = function(bool)
		self.enable = bool
		
		return self
	end

	self.setPosition = function(x, y)
		self.position.x = x
		self.position.y = y

		self.position_set = true
		
		return self
	end

	self.add = function(name, variable)
		self.allowed_variables[name] = variable
	end
	
	self.print_allowed_variables = function(x, y)
		if not self.enable then return end
		
		self.setPosition(x, y)
		for k, v in pairs(self.allowed_variables) do
			if type(v) == "table" then
				-- Prints variable name
				self.simple_print(tostring(k), self.position.x, self.position.y)
				self.newline()
				
				for k2, v2 in pairs(v) do
					self.simple_print(tostring(k2) .. " " .. tostring(v2), self.position.x, self.position.y)
					self.newline()
				end
			else
				self.simple_print(tostring(k) .. " " .. tostring(v), self.position.x, self.position.y)
				self.newline()
			end
		end
	end

	self.newline = function()
		self.position.y = self.position.y + self.text.newline_inc
	end

	self.simple_print = function(obj, x, y)
		love.graphics.setLineWidth(self.text.width)
		love.graphics.setColor(self.text.color.r, self.text.color.g, self.text.color.b, self.text.color.a)

		love.graphics.print(tostring(obj), x, y)
	end

	-- Printing every global tables
	self.print_G = function(x, y)
		if not self.enable then return end
		
		self.setPosition(x, y)

		for k, v in pairs(_G) do
			if type(v) ~= "function" then
				self.simple_print(tostring(k) .. "=" .. tostring(v), self.position.x, self.position.y)
				self.newline()
			end
		end
		
		return self
	end
	
	return setmetatable(self, {
		__tostring = function()
			return "[" .. self.type .. "." .. self.id .. "]"
		end,
	})
end

return LoveDebug
