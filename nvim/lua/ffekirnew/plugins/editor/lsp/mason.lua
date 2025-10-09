return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
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
        "prettierd",
        "stylua",
        "eslint",
        -- Python
        "mypy",
        "isort",
        "black",
        "autopep8",
        "autoflake",
        -- lua
        "lua-language-server",
        "stylua",
      },
    })
  end,
}
