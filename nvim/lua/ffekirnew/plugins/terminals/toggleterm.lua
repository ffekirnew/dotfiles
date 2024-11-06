return {
  "akinsho/toggleterm.nvim",
  lazy = false,
  version = "*",
  config = function()
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>tt", "<cmd>lua require('toggleterm').toggle()<cr>", { desc = "Toggle a terminal" })
  end,
}
