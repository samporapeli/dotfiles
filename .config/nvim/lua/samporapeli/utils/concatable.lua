-- Enable table concatenation with `..` operator
-- Usage:
-- local ct = require("samporapeli.utils.concatable")
-- ct.new({"a", "b"}) .. { "b", "c" }
-- => { "a", "b", "b", "c" }

local M = {}

local concat_mt = {
	__concat = function(a, b)
		local result = {}
		for _, value in pairs(a) do table.insert(result, value) end
		for _, value in pairs(b) do table.insert(result, value) end
		setmetatable(result, concat_mt)
		return result
	end
}

function M.new(t)
	local result = t or {}
	setmetatable(result, concat_mt)
	return result
end

return M
