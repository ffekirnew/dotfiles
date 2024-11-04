return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    local keymap = vim.keymap -- for conciseness
    local WIDTH = 60
    local HEIGHT = "auto"
    local STARTING_ROW = 5
    local STARTING_COL = "50%"

    require("noice").setup({
      views = {
        cmdline_popup = {
          position = {
            row = STARTING_ROW,
            col = STARTING_COL,
          },
          size = {
            width = WIDTH,
            height = HEIGHT,
          },
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = STARTING_ROW + 10,
            col = STARTING_COL,
          },
          size = {
            width = WIDTH,
            height = 10,
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
          },
        },
      },
      lsp = {
        progress = {
          enabled = false,
        },

        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },

      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },

      -- The following disables showing write messages
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "",
          },
          opts = { skip = true },
        },
      },

      keymap.set("n", "<leader>nd", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss Noice Messages." }),
    })
  end,
}
