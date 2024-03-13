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
        "tailwindcss", -- Tailwind Css
        "lua_ls", -- Lua
        "emmet_ls", -- Emmet
        "pyright", -- Python
        "gopls", -- Go
        "csharp_ls", -- C#
        "vtsls", -- TypeScript & JavaScript
        "jdtls", -- Java
        "clangd", -- C
        "dockerls", -- Docker
        "docker_compose_language_service", -- Docker Compose
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
    })

    mason_tool_installer.setup({
      ensure_installed = {
        "prettierd", -- prettier formatter
        "stylua", -- lua formatter
        "isort", -- python formatter
        "black", -- python formatter
        "ruff", -- python linter & formatter
        "mypy", -- python linter
        "eslint", -- js linter
        "gofumpt", -- go formatter
        "goimports", -- go formatter
        "csharpier", -- C# formatter
        "cpplint", -- C/C++ Linter
        "clang-format", -- C/C++ formatter
      },
    })
  end,
}
