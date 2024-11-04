return {
  "VonHeikemen/searchbox.nvim",
  dependencies = {
    { "MunifTanjim/nui.nvim" },
  },
  config = function()
    require("searchbox").setup({
      defaults = {
        reverse = false,
        exact = false,
        prompt = " ",
        modifier = "disabled",
        confirm = "off",
        clear_matches = true,
        show_matches = false,
      },
      popup = {
        relative = "win",
        position = {
          row = "4%",
          col = "100%",
        },
        size = 25,
        border = {
          style = "rounded",
          text = {
            top = " Search ",
            top_align = "left",
          },
        },
        win_options = {
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
        },
      },
    })

    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>hh", "<cmd>lua require('searchbox').replace()<CR>", { desc = "Open find and replace" })
    keymap.set("n", "<leader>hs", "<cmd>lua require('searchbox').match_all()<CR>", { desc = "Search in file" })
  end,
}
