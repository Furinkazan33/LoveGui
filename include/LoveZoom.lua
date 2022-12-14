local Zoom = require("include/Zoom")

local LoveZoom = {}
LoveZoom.__index = LoveZoom

function LoveZoom:new(config_file)
	local zoom = Zoom:new(config_file)
	local _set_zoom = zoom.set_zoom

	zoom.set_zoom = function(i)
		_set_zoom(i)

		-- Changing screen resolution
		love.window.setMode(zoom.c_res.w, zoom.c_res.h, { fullscreen = false, resizable=false, vsync=0 })

		-- Changing text size
		love.graphics.setNewFont(zoom.c_res.font)

	end

	return zoom
end

return LoveZoom
