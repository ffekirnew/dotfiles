vim.pack.add({
  "https://github.com/stevearc/conform.nvim",
})

local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff_organize_imports", "ruff_format" },
  },

  format_on_save = {
    lsp_fallback = true,
  },

  format_after_save = {
    lsp_fallback = true,
    async = true,
  },
})

-- set keymaps
local keymap = vim.keymap -- for conciseness
keymap.set({ "n", "v" }, "<leader>fm", function()
  conform.format({
    lsp_fallback = true,
    async = true,
  })
end, { desc = "Format file or range (in visual mode)" })
