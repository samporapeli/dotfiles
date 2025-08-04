local ct = require("samporapeli.utils.concatable")

return ct.new(require("samporapeli.plugins.basic"))
	.. ct.new(require("samporapeli.plugins.lualine"))
	.. ct.new(require("samporapeli.plugins.ide"))
