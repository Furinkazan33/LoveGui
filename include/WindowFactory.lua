local Window = require("include/Window")
local TopBar = require("include/TopBar")
local Button = require("include/Button")
local Menu = require("include/Menu")
local Item = require("include/Item")

local WindowFactory = {}


WindowFactory._get_by_uid = function(uid, managers)
    assert(uid, "No uid given")

    local result = nil

    for _, manager in pairs(managers) do
        if uid == manager.uid then 
            return manager
        end

	    local result = manager.get_unique(uid)
        
        if result then 
            return result
        end
	end

    return false
end

WindowFactory.get_by_uid = function(uid)
    local result = WindowFactory._get_by_uid(uid, modules.loader)

    if not result then
        result = WindowFactory._get_by_uid(uid, modules.manager)
    end

    assert(result, "WindowFactory.get_by_uid - No result for this uid : " .. uid)

    return result
end


WindowFactory.window = {
    deserialize = function(elt)
        assert(elt.uid, "WindowFactory.window.deserialize - uid required")
        assert(elt.parent, "WindowFactory.window.deserialize - parent uid required")

        local c = table.clone(elt)
        
        c.parent = WindowFactory.get_by_uid(elt.parent)
        c.context = modules.loader.context.get_unique("window")

        local window = Window:new(c)
        
		-- Children instanciations
        for k, child in pairs(elt.children) do
            if child.id == "Menu" then
                window.add(WindowFactory.menu.deserialize(window, child))

            elseif child.id == "Button" then
                window.add(WindowFactory.button.deserialize(window, child))

            elseif child.id == "TopBar" then
                window.add(WindowFactory.topbar.deserialize(window, child))
            else
                assert(false, "WindowFactory.window.deserialize - Unknown child id : " .. tostring(child.id))
            end
        end

        return window
    end,
}

WindowFactory.menu = {
    deserialize = function(parent, elt)
        assert(elt.uid, "WindowFactory.menu.deserialize - elt has no uid")
        
        local c = table.clone(elt)

        c.parent = parent
        c.context = modules.loader.context.get_unique("menu")

        local menu = Menu:new(c)

        for _, item in pairs(elt.children) do
            menu.add(WindowFactory.item.deserialize(menu, item))
        end

        return menu
    end,
}

WindowFactory.item = {
    deserialize = function(parent, elt)
        assert(elt.uid, "WindowFactory.item.deserialize - elt has no uid")

        local c = table.clone(elt)

        c.parent = parent
        c.context = modules.loader.context.get_unique("menu")

        return Item:new(c)
    end,
}

WindowFactory.topbar = {
    deserialize = function(parent, elt)
        assert(elt.uid, "WindowFactory.topbar.deserialize - elt has no uid")

        local c = table.clone(elt)

        c.context = modules.loader.context.get_unique("topbar")
        c.parent = parent

        return TopBar:new(c)
    end,
}

WindowFactory.button = {
    deserialize = function(parent, elt, context)
        assert(elt.uid, "WindowFactory.button.deserialize elt has no uid")

        local c = table.clone(elt)

        c.parent = parent
        c.context = modules.loader.context.get_unique("button")

        return Button:new(c)
    end,
}

return WindowFactory
