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
    local mason_lspconfig = require("mason-lspconfig")

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

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "html", -- Html
        "cssls", -- Css & Scss
        "vtsls", -- TypeScript & JavaScript
        "tailwindcss", -- Tailwind Css
        "emmet_ls", -- Emmet
        "pylsp", -- Python
        "dockerls", -- Docker
        "docker_compose_language_service", -- Docker Compose
        "lua_ls", -- Lua
        "prismals", -- Prisma
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
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
      },
    })
  end,
}
