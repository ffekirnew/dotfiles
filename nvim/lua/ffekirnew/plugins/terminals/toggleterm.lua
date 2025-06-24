return {
  "akinsho/toggleterm.nvim",
  lazy = false,
  version = "*",
  config = function()
    require("toggleterm").setup({
      start_in_insert = true,
      auto_scroll = true,
      shade_terminals = true,
      float_opts = {
        border = "curved", -- 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
        width = 135,
        height = 40,
        winblend = 3,
        zindex = 1000,
        title_pos = "left", -- | 'center' | 'right', position of the title of the floating window
      },
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
    })

    local keymap = vim.keymap
    -- Keymaps for opening terminals
    keymap.set(
      { "n", "t" },
      "<leader>th",
      "<cmd>:ToggleTerm direction=horizontal<cr>",
      { desc = "toggleterm: Toggle a horizontal terminal" }
    )
    keymap.set(
      { "n", "t" },
      "<leader>tv",
      "<cmd>:ToggleTerm direction=vertical size=20<cr>",
      { desc = "toggleterm: Toggle a vertical terminal" }
    )
    keymap.set(
      { "n", "t" },
      "<leader>tf",
      "<cmd>:ToggleTerm direction=float<cr>",
      { desc = "toggleterm: Toggle a floating terminal" }
    )
    keymap.set(
      { "n", "t" },
      "<leader>tt",
      "<cmd>:ToggleTerm direction=tab name=Terminal Tab<cr>",
      { desc = "toggleterm: Toggle a tab terminal" }
    )

    -- Custom terminal commands
    local Terminal = require("toggleterm.terminal").Terminal
    local custom_terminal_config = {
      dir = "git_dir",
      hidden = true,
      direction = "tab",
    }

    local lazygit = Terminal:new(vim.tbl_extend("force", {
      cmd = "lazygit",
      display_name = "LazyGit",
    }, custom_terminal_config))

    local gh_dash = Terminal:new(vim.tbl_extend("force", {
      cmd = "gh dash",
      display_name = "Gh Dash",
    }, custom_terminal_config))

    keymap.set("n", "<leader>lg", function()
      lazygit:toggle()
    end, {
      desc = "toggleterm: Toggle lazygit",
    })
    keymap.set("n", "<leader>ld", function()
      gh_dash:toggle()
    end, {
      desc = "toggleterm: Toggle GitHub Dash",
    })
  end,
}
