local EventManager = {}
EventManager.__index = EventManager

function EventManager:new(init_file, n)
    self = Manager:new("EventManager", init_file, n)
    self._add = self.add

    self.add = function(event)
        event.args.receiver = self.get_receiver(event)
        self._add(event)
    end

    self.pop_by_receiver = function(rec)
        local result = {}

        for k, v in pairs(self.children) do
            if v.args.receiver == rec then
                table.insert(result, k, v)
                self.remove(k)
            end
        end

        return result
    end

    --TODO: dispatch event to corresponding manager's event queue (to create) ?
    self.get_receiver = function(new_event)
        if new_event.uid == "message_to" then
            return new_event.args.target

        elseif string.sub(new_event.uid, 1, 4) == "all_" then
            return "Manager" --all managers

        elseif string.sub(new_event.uid, 1, 2) == "s_" then
            return "System"

        elseif string.sub(new_event.uid, 1, 2) == "u_" then
            return "User"

        elseif string.sub(new_event.uid, 1, 2) == "w_" then
            return gui.manager.window

        else
            assert(false, "event uid not listed in EventManager.add_receiver : " .. new_event.uid)
        end
    end

    self.update = function(dt)
        --for k, event in pairs(self.children) do
        --    self.dispatch_event(event)
        --end
    end

    -- Transforming config table into instance objects
    self.transform = function(elt)
        return Event:new(elt)
    end

    --self.init()

    return self
end

return EventManager

