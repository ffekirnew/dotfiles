return {
  "numToStr/FTerm.nvim",
  lazy = false,
  config = function()
    local keymap = vim.keymap -- for conciseness

    require("FTerm").setup({
      border = "single",
      dimensions = {
        height = 0.8,
        width = 0.8,
      },
    })

    keymap.set("n", "<leader>tf", "<cmd>lua require('FTerm').toggle()<cr>", { desc = "Open a floating terminal" })
  end,
}
