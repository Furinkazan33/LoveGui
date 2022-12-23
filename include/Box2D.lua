--[[
	Box2D is a Lua module that implements 2D rectangles :
	- intersection detection and render
	- Box2D children
	- drawing context (draw method to implement)
]]

local Position = require("include/Position")
local Size = require("include/Size")
local Boundary = require("include/Boundary")

local Box2D = {}
Box2D.__index = Box2D



--[[
	elt_example = {
		uid = unique_uid_inside_parent_children,
		parent = reference_to_parent,
		position = {},
		size = {},
		context = {},   -- for drawing purpose
		boundary = {},  -- limits the position
		visible = bool,
		focus = bool,
		moveable = bool,

		children = {},  -- Box2D children
	} 

	-- See serialize() method below for complete list
]]
function Box2D:new(elt)
	assert(elt.parent, "Box2D:new - missing parent")
	assert(elt.position, "Box2D:new - missing position")
	assert(elt.size, "Box2D:new - missing size")
	assert(elt.context, "Box2D:new - missing context")
	
	self = elt
	self.type = self.type or "System"
	self.id = self.id or "Box2D"
	
	self.position = Position:new(elt.position)
	self.size = Size:new(elt.size)
	
	if elt.boundary then
		self.boundary = Boundary:new(elt.boundary)
	else
		self.boundary = Boundary:Infinity()
	end
	
	self.visible = self.visible or true
	self.focus = self.focus or true
	self.moveable = self.moveable or true
	self.children = {}



	self.is_root = function()
		if self.parent then 
			return false
		else
			return true
		end
	end

	self.visibility = function(bool)
		self.visible = bool

		for k, child in pairs(self.children) do
			child.visibility(bool)
		end

		return self
	end

	self.show = function()
		self.focus = true
		self.visibility(true)

		return self
	end

	self.hide = function()
		self.focus = false
		self.visibility(false)

		return self
	end

	self.toggle = function()
		self.visibility(not self.visible)
		self.focus = self.visible
	end
	
	self.add = function(child)
		assert(child.uid, "Child has no uid !")
		
		table.insert(self.children, 1, child)
		return self
	end
	
	self.get_by_uid = function(uid)
		for _, child in pairs(self.children) do
			if uid == child.uid then
				return child
			end
		end
		return nil
	end
	
	self.get_by_id = function(id)
		local result = {}
		
		for _, child in pairs(self.children) do
			if id == child.id then
				table.insert(result, child)
			end
		end
		return result, #result
	end

	self.remove = function(uid)
		table.remove(self.children, uid)

		return self
	end

	self.is_inside = function(x, y)
		return x >= self.position.x and 
				x <= self.position.x + self.size.w and 
				y >= self.position.y and 
				y <= self.position.y + self.size.h 
	end

	self.move = function(dx, dy)
		if self.moveable then
			local x = self.position.x + dx
			local y = self.position.y + dy

			if self.boundary and not self.boundary.infinity then
				if x > self.boundary.x_max then x = self.boundary.x_max end
				if y > self.boundary.y_max then y = self.boundary.y_max end
				if x < self.boundary.x_min then x = self.boundary.x_min end
				if y < self.boundary.y_min then y = self.boundary.y_min end
			end

			self.position.x = x
			self.position.y = y


			for k,v in pairs(self.children) do
				v.move(dx, dy, dt)
			end
		end

		return self.position
	end

	self.set_zoom = function(coef)
		self.position.set_zoom(coef)
		
		self.size.set_zoom(coef)
		
		if self.boundary then 
			self.boundary.set_zoom(coef) 
		end

		if self.font then 
			self.font = self.font * coef
		end

		for k, v in pairs(self.children) do
			v.set_zoom(coef)
		end
	end

	self.intersection = function(box2)
		local maxLeftX = math.max(self.position.x, box2.position.x)
		local MinRightX = math.min(self.position.x + self.size.w, box2.position.x + box2.size.w)
		local maxTopY = math.max(self.position.y, box2.position.y)
		local minBottomY = math.min(self.position.y + self.size.h, box2.position.y + box2.size.h)

		if MinRightX >= maxLeftX and minBottomY >= maxTopY then 				
			local new_i = self.clone()
			new_i.uid = "i_" .. new_i.uid
			new_i.position.x = maxLeftX
			new_i.position.y = maxTopY
			new_i.size.w = MinRightX - maxLeftX
			new_i.size.h = minBottomY - maxTopY
			
			return new_i
		else
			return nil
		end
	end

	self.serialize = function()
		local elt = {
			id = self.id,
			type = self.type,
			uid = self.uid,
			text = self.text,
			title = self.title,
			event = self.event,
			parent = self.parent.uid,
			position = self.position.serialize(),
			size = self.size.serialize(),
			context = self.context.serialize(),
			boundary = self.boundary.serialize(),
			visible = self.visible,
			focus = self.focus,
			moveable = self.moveable,
			font = self.font,
			
			children = {}
		}
		
		for k, child in pairs(self.children) do
			table.insert(elt.children, k, child.serialize())
		end
		
		return elt
	end
	
	self.deserialize = function(elt, parent)
		elt.parent = parent
		elt.position = elt.position.deserialize()
		elt.size = elt.size.deserialize()
		elt.context = elt.context.deserialize()
		elt.boundary = elt.boundary.deserialize()
		
		return Box2D:new(elt)
	end
	
	self.clone = function()
		return self.deserialize(self.serialize(), self.parent)
	end
	
	self.tostring = function()
		return table.tostring(self.serialize())
	end
	
	self.to_simple_string = function()
		local result = "uid = " .. self.uid .. 
			", parent = " .. self.parent.uid .. 
			", position = " .. self.position.tostring() .. 
			", context = " .. self.context.uid
			
		if self.boundary then
			result = result .. ", boundary = " .. self.boundary.tostring()
		end
		
		return result
	end

	self.draw_children = function(delta)
		if not delta then 
			delta = Position:new({ x = 0, y = 0 }) 
		end

		-- Position spreading
		delta = delta - self.position

		for _, child in pairs(self.children) do
			child.draw(delta)
		end

		return self
	end

	--[[ USER: to override in inherited tables ]]
	self.draw = function(delta)
		if self.visible then
			--[[ USER: to complete ]]
		end
		
		self.draw_children(delta)
	end

	return setmetatable(self, {
		__eq = function(b1, b2)
			return b1.uid == b2.uid
		end,

		__tostring = function()
			return 	self.type .. "." .. self.id .. "[" .. self.to_simple_string() .. "]"
		end,
	})

end



return Box2D
