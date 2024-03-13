return {
  "hedyhli/outline.nvim",
  config = function()
    require("outline").setup({
      -- Your setup opts here (leave empty to use defaults)
    })

    local keymap = vim.keymap -- for conciseness
    keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
  end,
}
