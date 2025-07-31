local ide_mode = require("samporapeli.config.ide_mode")

return {
	{
		"dart-lang/dart-vim-plugin",
		ft = "dart",
		enabled = ide_mode.enabled,
	},
}
