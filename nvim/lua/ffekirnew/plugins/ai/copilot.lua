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
          next = "<C-]>",
          prev = "<C-[>",
          discard = "<C-k>",
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
      "i",
      "<leader>cp",
      "<cmd>lua require('copilot.suggestion').next()<cr>",
      { desc = "Show the next copilot suggestion" }
    )
  end,
}
