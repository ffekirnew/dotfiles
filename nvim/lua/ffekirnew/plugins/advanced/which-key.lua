vim.pack.add({
  "https://github.com/folke/which-key.nvim",
})

vim.o.timeout = true
vim.o.timeoutlen = 500

require("which-key").setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
})
