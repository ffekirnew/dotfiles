return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = true,
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
    config = function()
      local avante = require("avante")
      local keymap = vim.keymap -- for conciseness

      avante.setup({
        provider = "copilot",
        auto_suggestions_provider = "copilot",
        behaviour = {
          auto_suggestions = true,
        },
        mappings = {
          submit = {
            normal = "<CR>",
            insert = "<CR>",
          },
        },
        windows = {
          width = 25, -- default % based on available width
          sidebar_header = {
            enabled = true, -- falst, true to enable/disable the header
            align = "left", -- left, center, right for title
            rounded = false,
          },
          input = {
            prefix = "> ",
            height = 4, -- Height of the input window in vertical layout
          },
          ask = {
            floating = true,
          },
        },
      })

      keymap.set("n", "<leader>aa", "<cmd>AvanteAsk<cr>", { desc = "Initiate an Avante ask session" })
      keymap.set("n", "<leader>ae", "<cmd>AvanteEdit<cr>", { desc = "Edit selected code blocks with Avante" })
      keymap.set("n", "<leader>at", "<cmd>AvanteToggle<cr>", { desc = "Toggle the Avante interface" })
      keymap.set("i", "<leader>at", "<cmd>AvanteToggle<cr>", { desc = "Toggle the Avante interface" })
      keymap.set("n", "<leader>ac", "<cmd>AvanteClear<cr>", { desc = "Clear the current Avante session" })
      keymap.set("n", "<leader>as", "<cmd>AvanteShowSuggestions<cr>", { desc = "Display Avante suggestions" })
    end,
  },
}
