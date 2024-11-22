return {
  "marko-cerovac/material.nvim",
  priority = 1000,

  config = function()
    local material = require("material")

    material.setup({
      lualine_style = "stealth", -- the stealth style, other options = ['default']
    })

    vim.cmd([[colorscheme material]])

    -- keymaps
    local keymap = vim.keymap -- for conciseness
    keymap.set(
      "n",
      "<leader>mm",
      [[<Cmd>lua require('material.functions').toggle_style()<CR>]],
      { noremap = true, silent = true, desc = "Toggle Material style" }
    )
    keymap.set(
      "n",
      "<leader>ml",
      [[<Cmd>lua require('material.functions').change_style('lighter')<CR>]],
      { noremap = true, silent = true, desc = "Change to lighter Material style" }
    )
    keymap.set(
      "n",
      "<leader>md",
      [[<Cmd>lua require('material.functions').change_style('darker')<CR>]],
      { noremap = true, silent = true, desc = "Change to darker Material style" }
    )
  end,
}
