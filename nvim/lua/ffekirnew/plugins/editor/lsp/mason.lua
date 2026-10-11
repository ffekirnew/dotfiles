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
    -- JS, TS, CSS, HTML
    "vtsls",
    "prettierd",
    "stylua",
    "eslint",
    -- Python
    "pyright",
    "mypy",
    "isort",
    "black",
    "autopep8",
    "autoflake",
    -- lua
    "lua-language-server",
  },
})
