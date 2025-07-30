local M = {}

M.enabled = not not os.getenv("NVIM_IDE")

return M
