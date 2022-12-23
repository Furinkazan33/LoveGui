local Event = {}
Event.__index = Event


function Event:new(elt)
	assert(elt.uid, "Missing uid")
	
    self = elt
	self.type = "System"
    self.id = "Event"

	self.serialize = function()
		return gui.factory.event.serialize(self)
	end
	
	self.deserialize = function(elt)
		return gui.factory.event.deserialize(elt)
	end
	
	self.clone = function()
		return gui.factory.event.clone(self)
    end
	
	self.tostring = function()
		local result = "["
		result = result .. self.uid .. ", "
		result = result .. table.tostring(self.args) .. "]"
		
		return result
	end
		
    return setmetatable(self, {
		__tostring = function()
			return 	self.type .. "." .. self.id .. " " .. self.tostring()
		end,
	})
end


return Event

