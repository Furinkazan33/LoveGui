local Button = {}
Button.__index = Button

function Button:new(elt)
    self = LoveBox2D:new(elt)
    self.id = "Button"

    self.send_event = function()
        assert(self.event, "Button has no event uid")

        local event = gui.factory.event.create(self.event, { sender = self, target = self.parent }) 
        gui.manager.event.add(event)

        return self
    end

    self.update = function()
        if self.clicked_and_release then 
            self.send_event()
            
            self.reinit_click()
        end

        return self
    end

    self.deserialize = function(elt)
        assert(false, "Impossible to deserialize a Button")
    end

    self.clone = function()
        assert(false, "Impossible to clone a Button")
	end

    return self
end


return Button
