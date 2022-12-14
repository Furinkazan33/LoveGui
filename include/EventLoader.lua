local EventLoader = {}
EventLoader.__index = EventLoader

function EventLoader:new(config_file, n)
    self = Manager:new("EventLoader", config_file, n)

    -- Transforming config table into instance objects
    self.transform = function(elt)
        local event = Event:new(elt)

        --print(event)

        return event
    end

    --self.init()

    return self
end

return EventLoader

