return {
  "zbirenbaum/copilot.lua",
  lazy = true,
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      -- Possible configurable fields can be found on:
      -- https://github.com/zbirenbaum/copilot.lua#setup-and-configuration
      suggestion = {
        enable = true,
        auto_trigger = true,
        keymap = {
          accept = "<C-l>",
        },
      },
      panel = {
        enable = false,
      },
      filetypes = {
        markdown = true,
      },
    })

    local keymap = vim.keymap -- for conciseness
    keymap.set(
      "n",
      "<leader>cp",
      "<cmd>lua require('copilot.suggestion').next()<cr>",
      { desc = "Show the next copilot suggestion" }
    )
    keymap.set(
      "n",
      "<leader>cpw",
      "<cmd>lua require('copilot.suggestion').accept_word()<cr>",
      { desc = "Accepts the word suggested by copilot" }
    )
    keymap.set(
      "n",
      "<leader>cpl",
      "<cmd>lua require('copilot.suggestion').accept_line()<cr>",
      { desc = "Accepts the line suggested by copilot" }
    )
  end,
}
