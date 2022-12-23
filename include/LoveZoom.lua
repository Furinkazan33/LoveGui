local Zoom = require("include/Zoom")

local LoveZoom = {}
LoveZoom.__index = LoveZoom

function LoveZoom:new(config_file)
	local zoom = Zoom:new(config_file)
	local _set_zoom = zoom.set_zoom

	zoom.set_zoom = function(i)
		_set_zoom(i)

		-- Changing screen resolution
		love.window.setMode(zoom.current.w, zoom.current.h, { fullscreen = false, resizable=false, vsync=0 })
	end

	return zoom
end

return LoveZoom
