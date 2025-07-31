local M = {}

local env_value = os.getenv("NVIM_IDE")
M.enabled = env_value == "1" or string.lower(env_value or "") == "true" or string.lower(env_value or "") == "yes"

return M
