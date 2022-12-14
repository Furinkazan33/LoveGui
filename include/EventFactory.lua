local EventFactory = {}
EventFactory.__index = EventFactory

function EventFactory.create(uid, args)
    local event = modules.loader.event.get_unique(uid).clone()

    local ret, k = EventFactory.exist_args(event.args, args)
    assert(ret, "EventManager.create_event - missing argument : " .. k)
    
    event.args = args

    return event
end

function EventFactory.serialize(event)
    local elt = {
		uid = event.uid,
		args = {
			content = event.args.content,
			position = event.args.position,
			value =  event.args.value,
			setup = event.args.setup,
			dx = event.args.dx,
			dy = event.args.dy,
		}
	}
	if event.args.sender then
		elt.args.sender = event.args.sender.uid
	end
	if event.args.target then
		elt.args.target = event.args.target.uid
	end
	if event.args.receiver then
		elt.args.receiver = event.args.receiver.uid
	end
		
	return elt
end

function EventFactory.deserialize(elt)
	if elt.args.sender then
		elt.args.sender = global_get_by_uid(elt.args.sender)
	end
		
	if elt.args.target then
		elt.args.target = global_get_by_uid(elt.args.target)
	end
	if elt.args.receiver then
		elt.args.receiver = global_get_by_uid(elt.args.receiver)
	end
	
	return Event:new(elt)
end


function EventFactory.clone(event)
	return EventFactory.deserialize(EventFactory.serialize(event))
end

-- Every ref_args exists in args (1st level only)
function EventFactory.exist_args(ref_args, args)
    for k, v in pairs(ref_args) do
        if not args[k] then 
            return false, tostring(k)
        end
    end

    return true, ""
end


return EventFactory

