local Box2D = require("include/Box2D")

local LoveBox2D = {}
LoveBox2D.__index = LoveBox2D


function LoveBox2D:new(elt)
	self = Box2D:new(elt)
	self.hovered = false
	self.dragged = false

	self.is_hovered = function(x, y)
		if self.is_inside(x, y) then
			return true
		else
			return false
		end
	end

	self.forceHovered = function(value)
		self.hovered = value
		
		for k, v in pairs(self.children) do
			v.forceHovered(value)
		end
		
		return self
	end

	self.setHovered = function(x, y)			
		-- No updates when mouse button is down.
		-- This avoids drag cancel as mouse gets outside window when moving
		if not self.dragged then
			if self.is_inside(x, y) then
				self.hovered = true
			else
				self.hovered = false
			end

			for k, v in pairs(self.children) do
				v.setHovered(x - self.position.x, y - self.position.y)
			end
		end
		
		return self.hovered
	end
	
	self.setDragged = function(bool)
		self.dragged = bool
		
		for _, child in pairs(self.children) do
			child.dragged = bool
		end
	end
	
	self.setClickedAndRelease = function()
		if self.clicked and not love.mouse.isDown(1) then
			self.clicked = false --not recursive because buttons need to be clicked
			self.setDragged(false)
		
			if self.hovered then 
				self.clicked_and_release = true
			else
				self.clicked_and_release = false
			end
		end
		
		for k, v in pairs(self.children) do
			v.setClickedAndRelease()
		end
		
		return self.clicked_and_release
	end
	
	self.forceClicked = function(bool)
		self.clicked = bool
		
		for k, v in pairs(self.children) do
			v.forceClicked(bool)
		end
		
		return self.clicked
	end
	
	self.reinit_click = function()
		self.clicked = false
		self.clicked_and_release = false
	end
	
	self.setClicked = function(x, y)
		if self.hovered and love.mouse.isDown(1) then
			self.clicked = true
		end
		
		for k, v in pairs(self.children) do
			v.setClicked(x - self.position.x, y - self.position.y)
		end
		
		return self.clicked
	end
	
	
	self.draw_fill = function(delta)
		if not delta then
			delta = { x = 0, y = 0 }
		end
		
		local lcontext = self.context
		
		if self.dragged and self.context.dragged then
			lcontext = self.context.dragged
		elseif self.hovered and self.context.hovered then
			lcontext = self.context.hovered
		end
		
		if lcontext.fill then
			love.graphics.setColor(lcontext.fill.r, lcontext.fill.g, lcontext.fill.b, lcontext.fill.a )
			love.graphics.rectangle("fill", self.position.x - delta.x, self.position.y - delta.y, self.size.w, self.size.h)
		end
	end

	self.draw_line = function(delta)
		if not delta then
			delta = { x = 0, y = 0 }
		end
		
		local lcontext = self.context
		
		if self.dragged and self.context.dragged then
			lcontext = self.context.dragged
		elseif self.hovered and self.context.hovered then
			lcontext = self.context.hovered
		end

		if lcontext.line then
			love.graphics.setLineWidth(lcontext.line_width)
			love.graphics.setColor(lcontext.line.r, lcontext.line.g, lcontext.line.b, lcontext.line.a )
			love.graphics.rectangle("line", self.position.x - delta.x, self.position.y - delta.y, self.size.w, self.size.h)
		end
	end

	self.draw = function(delta)		
		if self.context and self.visible then
			self.draw_fill(delta)

			self.draw_line(delta)
		end
		for k, v in pairs(self.children) do
			self.draw_children(v, delta)
		end
	end

	return self
end



return LoveBox2D
