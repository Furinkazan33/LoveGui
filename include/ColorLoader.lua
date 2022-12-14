local ColorLoader = {}
ColorLoader.__index = ColorLoader

function ColorLoader:new(config_file, n)
	self = Manager:new("ColorLoader", config_file, n)
	
	
	self.transform = function(elt)
		local rgb = Rgb:new(elt)
		
		--print(rgb)
		
		return rgb
	end
	
	--self.init()

    return self
end

return ColorLoader
