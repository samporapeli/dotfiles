return function (use)
  use "wbthomason/packer.nvim"
  use "neovim/nvim-lspconfig"
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-vsnip"
  use "hrsh7th/vim-vsnip"
  use "github/copilot.vim"
  if vim.bo.filetype == "dart" then
    require("samporapeli.ide.dart.plugins")(use)
  end
end
