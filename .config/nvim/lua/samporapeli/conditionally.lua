-- Usage:
-- local conditionally = require("samporapeli.conditionally")
-- conditionally(1 == 2).if_true("one equals two").if_false("one does not equal two")
-- => "one does not equal two"

return function(condition)
	return {
		if_true = function(then_value)
			return {
				if_false = function(else_value)
					if condition then
						return then_value
					else
						return else_value
					end
				end
			}
		end
	}
end
