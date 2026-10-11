vim.pack.add({
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/williamboman/mason-lspconfig.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

-- import mason
local mason = require("mason")

-- import mason-lspconfig
local mason_tool_installer = require("mason-tool-installer")

-- enable mason and configure icons
mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})

mason_tool_installer.setup({
  ensure_installed = {
    -- Python
    "basedpyright", -- types, completion, navigation
    "ruff", -- lint, format, organize imports
    -- lua (for editing this config)
    "lua-language-server",
    "stylua",
  },
})
