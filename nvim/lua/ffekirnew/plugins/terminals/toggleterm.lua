return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {--[[ things you want to change go here]]
  },

  config = function()
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>tt", "<cmd>lua require('toggleterm').toggle()<cr>", { desc = "Toggle a terminal" })
  end,
}
