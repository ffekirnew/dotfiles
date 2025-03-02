return {
  "https://github.com/tjdevries/present.nvim",
  config = function()
    local present = require("present")

    local keymap = vim.keymap -- for conciseness
    keymap.set("n", "<leader>sp", "<cmd>:PresentStart<cr>", { desc = "Present the current file" })
  end,
}
