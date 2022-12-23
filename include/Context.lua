local Context = {}
Context.__index = Context


function Context:new(elt)
	local self = elt
	self.type = "System"
	self.id = "Context"
		
	self.serialize = function(factory)
		return gui.factory.context.serialize(self)
	end
	
	self.deserialize = function(elt)
		return gui.factory.context.deserialize(elt)
	end
	
	self.clone = function()
		return gui.factory.context.clone(self)
	end
	
	self.tostring = function()
		local result = ""
		result = result .. self.fill.tostring() .. ", "
		result = result .. self.line.tostring() .. ", "
		result = result .. self.text.tostring()
		
		return result
	end
	
	return setmetatable(self, {
		__tostring = function()
			return 	self.type .. "." .. self.id .. self.tostring()
		end,

	})
end


return Context