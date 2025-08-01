local M = {}

-- Hash table for O(1) average-case lookup
local truthy_values = {
	["1"] = true,
	["enabled"] = true,
	["true"] = true,
	["yes"] = true,
}

M.is_truthy = function (value_to_test)
	return truthy_values[string.lower(tostring(value_to_test or ""))] or false
end

return M
