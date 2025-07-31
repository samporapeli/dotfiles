local M = {}

local env_value = os.getenv("NVIM_ICON_FONT")
M.enabled = env_value == "1" or string.lower(env_value or "") == "true"

return M
