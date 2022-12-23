local ContextLoader = {}
ContextLoader.__index = ContextLoader

function ContextLoader:new(config_file, n)
	self = Manager:new("ContextLoader", config_file, n)
	
	self.transform = function(elt)
		local context = gui.factory.context.deserialize(elt)
		
		--print(context)
		
		return context
	end
	
	
	--self.init()

    return self
end

return ContextLoader
