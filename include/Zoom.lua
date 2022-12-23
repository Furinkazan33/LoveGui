local Zoom = {}
Zoom.__index = Zoom

function Zoom:new(config_file)
	self = {
		config_file = config_file,
		c_config = require(config_file),
		ZOOM = { init = 1.0, value = 1.0, coef = 1.0, current_res = 1 },
		reg = {
			tables = {},
			objects = {},
		}
	}
	
	self.apply = function(new_zoom)
		self.ZOOM.coef = new_zoom / self.ZOOM.value
		self.ZOOM.value = new_zoom
		
		for _, t in pairs(self.reg.tables) do
			for k, o in pairs(t) do
				o.set_zoom(self.ZOOM.coef)
			end
		end

		for _, o in pairs(self.reg.objects) do
			o.set_zoom(self.ZOOM.coef)
		end
		
		return self
	end

	-- Registered object has to implement set_zoom method
	self.register = function(e)
		table.insert(self.reg.objects, e)
		
		return self
	end

	self.register_table = function(t)
		table.insert(self.reg.tables, t)
		
		return self
	end

	-- Extend this method in graphic engine if needed
	self.set_zoom = function(i)
		if not i then i = 1 end

		self.current = self.c_config.list[i]

		-- Change zoom for every displayable object
		self.apply(self.ZOOM.init * self.current.coef)
		
		return self
	end

	self.next = function()
		self.ZOOM.current_res = self.ZOOM.current_res + 1

		if self.ZOOM.current_res > #self.c_config.list then 
			self.ZOOM.current_res = 1 
		end

		self.set_zoom(self.ZOOM.current_res)

		return self
	end
	
	self.previous = function()
		self.ZOOM.current_res = self.ZOOM.current_res - 1

		if self.ZOOM.current_res == 0 then 
			self.ZOOM.current_res = #self.c_config.list 
		end

		self.set_zoom(self.ZOOM.current_res)

		return self
	end
	
	return self
end




return Zoom

