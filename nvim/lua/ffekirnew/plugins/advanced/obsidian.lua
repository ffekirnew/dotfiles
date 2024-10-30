return {
  "epwalsh/obsidian.nvim",
  lazy = false,
  ft = "markdown",
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
  },

  config = function()
    local obsidian = require("obsidian")

    obsidian.setup({
      workspaces = {
        {
          name = "personal",
          path = "/Users/ffekirnew/Documents/personal",
        },
      },
      notes_subdir = "inbox",
      new_notes_location = "notes_subdir",

      disable_frontmatter = false,
      templates = {
        subdir = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M:%S",
      },

      note_frontmatter_func = function(note)
        local out = {
          date = note.date or os.date(),
          tags = note.tags or {},
          hubs = note.hubs or {},
          urls = note.urls or {},
        }

        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        return out
      end,

      note_id_func = function(title)
        local suffix = ""
        local current_datetime = os.date("!%Y-%m-%d-%H%M%S", os.time() + 1 * 3600)
        if title ~= nil then
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return current_datetime .. "_" .. suffix
      end,

      mappings = {
        -- overrides the 'gf' mapping to work on markdown/wiki links within your vault
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- toggle check-boxes
        ["<leader>ch"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
      },
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      ui = {
        -- Disable some things below here because I set these manually for all Markdown files using treesitter
        checkboxes = {},
        bullets = {},
      },
    })

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set(
      "n",
      "<leader>on",
      "<cmd>:tabnew New Note | ObsidianNew<cr>",
      { desc = "Create a new obsidian note in another tab" }
    )
    keymap.set(
      "n",
      "<leader>ok",
      ":!mv '%:p' /Users/ffekirnew/Documents/personal/zettelkasten<cr>:bd<cr>",
      { desc = "move file in current buffer to zettelkasten folder" }
    )
    keymap.set("n", "<leader>odd", ":!rm '%:p'<cr>:bd<cr>", { desc = "delete file in current buffer" })
    keymap.set(
      "n",
      "<leader>o",
      ':Telescope find_files search_dirs={"/Users/ffekirnew/Documents/personal"}<cr>',
      { desc = "Find and open notes in the same tab" }
    )
    keymap.set(
      "n",
      "<leader>os",
      ':tabnew Find Notes | :Telescope find_files search_dirs={"/Users/ffekirnew/Documents/personal"}<cr>',
      { desc = "Find and open notes in a new tab" }
    )
  end,
}
