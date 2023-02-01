local packer = require("packer")

return packer.startup(function (use)
  use "wbthomason/packer.nvim"
  use "neovim/nvim-lspconfig"
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
end)
