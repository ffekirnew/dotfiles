return {
  "numToStr/FTerm.nvim",
  lazy = false,
  config = function()
    require("FTerm").setup({
      border = "single",
      dimensions = {
        height = 0.95,
        width = 0.9,
      },
    })

    local keymap = vim.keymap -- for conciseness
    keymap.set("n", "<leader>tf", "<cmd>lua require('FTerm').toggle()<cr>", { desc = "Toggle a floating terminal" })
    keymap.set(
      "t",
      "<leader>tf",
      '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>',
      { desc = "Toggle a floating terminal" }
    )
  end,
}
