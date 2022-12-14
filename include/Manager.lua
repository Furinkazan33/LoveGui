local Manager = {}
Manager.__index = Manager

-- id (required) 		 : Manager's unique id
-- init_file (optionnal) : contains in the field "list" every components to load
--   that will be transformed using the Manager.transform method
--   when the Manager.init function is called
-- instance_n (optionnal) : enables multiple instances with the same id
function Manager:new(id, init_file, instance_n)
    self = {}
	self.type = "System"
	self.id = id
	self.children = {}
	
	if not instance_n then instance_n = "" else instance_n = "_" .. tostring(instance_n) end
	self.uid = self.id .. instance_n
	
	
	if init_file then 
        self.config = require(init_file)
    end

	self.add = function(elt)
		assert(elt.uid, "Element has no uid !")
		
		table.insert(self.children, 1, elt)

		return self
	end
		
	self.touch = function(k)
		local touched = self.get(k)
		self.remove(k)
		self.add(touched)
		
		return self
	end

	self.remove = function(k)
		assert(k, "Manager.remove - argument required")
		assert(self.children[k], "Manager.remove - no element with this index : " .. k)
		
		table.remove(self.children, k)

		return self
	end

	self.get = function(k)
		if not k then 
			return self.children
		else
			assert(self.children[k], "Manager.get - no element with this index : " .. k)
			return self.children[k]
		end
	end
	
	self.get_by_uid = function(uid)
		local result = {}
		
		for k, child in pairs(self.children) do
			if child.uid == uid then 
				table.insert(result, child)
			end
		end
		
		return result, #result
	end
	
	self.get_unique = function(uid)
		assert(uid, "Manager.get_unique - uid required")
		local result, n = self.get_by_uid(uid)
	
		assert(n <= 1, "Multiple occurence of this uid : " .. uid)
	
		return result[1]
	end
	
	-- Override this function to your needs (currently doing nothing)
	-- Basically this function transforms config table element into an instance object
	self.transform = function(elt)
		return elt
	end
	
	-- Call this function after Manager instance creation to populate with instance objects
	self.init = function()
		if self.config and self.config.list then
			for _, elt in pairs(self.config.list) do
				self.add(self.transform(elt))
			end
		end
	end
	
	self.set_zoom = function(coef)
		for _, elt in pairs(self.children) do
			elt.set_zoom(coef)
		end
	end


    return setmetatable(self, {
		__eq = function(m1, m2)
			return m1.uid == m2.uid
		end,
		
	})
end


return Manager
