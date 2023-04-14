local packer = require("packer")

return packer.startup(function (use)
  use "wbthomason/packer.nvim"
  use "neovim/nvim-lspconfig"
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-vsnip"
  use "hrsh7th/vim-vsnip"
end)
