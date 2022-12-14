local ContextFactory = {}
ContextFactory.__index = ContextFactory

function ContextFactory.clone(context)
     return ContextFactory.deserialize(context.serialize(), context.parent)
end

function ContextFactory.serialize_rgb_to_color(rgb)
	return { 
		uid = rgb.uid,
		concentration = rgb.c,
		alpha = rgb.a,
	}
end

function ContextFactory.deserialize_color_to_rgb(c_color)
	if not c_color then return nil end
	
	local rgb = modules.loader.color.get_unique(c_color.uid).clone()
	return rgb.concentration(c_color.concentration).alpha(c_color.alpha)
end

function ContextFactory.deserialize(elt)
	elt.fill = ContextFactory.deserialize_color_to_rgb(elt.fill)
	elt.line = ContextFactory.deserialize_color_to_rgb(elt.line)
	
	if elt.hovered then
		elt.hovered.fill = ContextFactory.deserialize_color_to_rgb(elt.hovered.fill)
		elt.hovered.line = ContextFactory.deserialize_color_to_rgb(elt.hovered.line)
	end
	
	if elt.dragged then
		elt.dragged.fill = ContextFactory.deserialize_color_to_rgb(elt.dragged.fill)
		elt.dragged.line = ContextFactory.deserialize_color_to_rgb(elt.dragged.line)
	end
	
	elt.text = ContextFactory.deserialize_color_to_rgb(elt.text)
	
	return Context:new(elt)
end

function ContextFactory.serialize(context)
	local elt = {
		uid = context.uid,
		fill = ContextFactory.serialize_rgb_to_color(context.fill), 
		line = ContextFactory.serialize_rgb_to_color(context.line),
		line_width = context.line_width,

		hovered = {
			fill = ContextFactory.serialize_rgb_to_color(context.hovered.fill), 
			line = ContextFactory.serialize_rgb_to_color(context.hovered.line),
			line_width = context.hovered.line_width,
		},
		dragged = {
			fill = ContextFactory.serialize_rgb_to_color(context.dragged.fill),
			line = ContextFactory.serialize_rgb_to_color(context.dragged.line),
			line_width = context.dragged.line_width,
		},
		text = ContextFactory.serialize_rgb_to_color(context.text),
	}
	
	return elt
end

function ContextFactory.clone(context)
     return ContextFactory.deserialize(ContextFactory.serialize(context))
end


return ContextFactory
