local MyTable = table



-- Append to a
MyTable.append = function(a, b)
	for i = 1, #b do
		a[#a + i] = b[i]
	end
end

-- Attention aux références récursives
MyTable.clone = function(t)
	local result = {}
	
	for k, v in pairs(t) do
		if type(v) == "table" then
			result[k] = MyTable.clone(v)
		else
			result[k] = v
		end
	end
	return result
end

MyTable.tostring = function(t)
	local result = "{ "
	
	for k, v in pairs(t) do
		result = result .. tostring(k) .. " = "
		
		if type(v) == "table" then
			result = result .. MyTable.tostring(v)
		else
			result = result .. tostring(v) .. ", "
		end
		
	end
	
	result = result .. "}, "
	
	return result
end

MyTable.print = function(t, print_fonctions, fn_name)
	if not fn_name then fn_name = "" end
	
	print("========== " .. fn_name .. " start ==========")

	MyTable._print(t, "", print_fonctions)

	print("========== " .. fn_name .. " end ============")
end

MyTable._print = function(t, decal_str, print_fonctions)
	for k, v in pairs(t) do
		if k ~= "_elt" and k ~= "parent" then
			if type(v) == "table" then
				print(decal_str .. "table " .. tostring(k) .. " :")
				MyTable._print(v, decal_str .. "\t", print_fonctions)
				
			elseif type(v) == "function" then
				if print_fonctions then
					print(decal_str .. tostring(k), tostring(v))
				end
				
			else
				print(decal_str .. tostring(k), tostring(v))
				
			end
		end
	end
end


return MyTable
