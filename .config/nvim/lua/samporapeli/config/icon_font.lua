local is_truthy = require("samporapeli.config.utils").is_truthy

local M = {}

M.enabled = is_truthy(os.getenv("NVIM_ICON_FONT"))

return M
