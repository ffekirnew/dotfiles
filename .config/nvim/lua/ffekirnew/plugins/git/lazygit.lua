return {
  "kdheepak/lazygit.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>lg", "<cmd>LazyGit<CR>", { desc = "Toggle LazyGit" }) -- toggle lazy git
  end,
}
