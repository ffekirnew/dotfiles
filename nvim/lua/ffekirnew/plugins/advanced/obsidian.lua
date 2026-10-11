vim.pack.add({
  "https://github.com/epwalsh/obsidian.nvim",
})

local obsidian = require("obsidian")
-- Vault location comes from $NOTES_DIR (set in .zshrc) so it works on any machine
local notes_dir = vim.env.NOTES_DIR or vim.fn.expand("~/personal/notes")
obsidian.setup({
  ui = {
    enable = false,
  },
  workspaces = {
    {
      name = "personal",
      path = notes_dir,
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

  daily_notes = {
    folder = "notes/daily-notes",
    default_tags = { "daily-notes" },
    -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
    template = "daily-note.md",
  },

  note_frontmatter_func = function(note)
    local out = {
      date = note.date or os.date(),
      tags = note.tags or {},
      hubs = note.hubs or {},
      urls = note.urls or {},
      status = note.note_status or "active",
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
    ["<leader>of"] = {
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
    nvim_cmp = false, -- archived obsidian.nvim has no blink.cmp source
    min_chars = 2,
  },
})

-- set keymaps
local keymap = vim.keymap -- for conciseness
keymap.set(
  "n",
  "<leader>on",
  "<cmd>:tabnew New Note | ObsidianNew<cr>",
  { desc = "Create a new obsidian note in a new tab" }
)
keymap.set(
  "n",
  "<leader>ot",
  "<cmd>:tabnew New Note | ObsidianNewFromTemplate<cr>",
  { desc = "Create a new obsidian note from template in a new tab" }
)
keymap.set(
  "n",
  "<leader>od",
  "<cmd>:tabnew New Daily Note | ObsidianToday<cr>",
  { desc = "Create/open today's note in a new tab" }
)
keymap.set(
  "n",
  "<leader>os",
  function()
    vim.cmd("tabnew Find Notes")
    require("telescope.builtin").find_files({ search_dirs = { notes_dir } })
  end,
  { desc = "Find and open notes in a new tab" }
)
keymap.set(
  "n",
  "<leader>ok",
  function()
    vim.cmd("!mv " .. vim.fn.shellescape(vim.fn.expand("%:p")) .. " " .. vim.fn.shellescape(notes_dir .. "/zettelkasten"))
    vim.cmd("bd")
  end,
  { desc = "Move current note into the zettelkasten folder" }
)
keymap.set("n", "<leader>ox", ":!rm '%:p'<cr>:bd<cr>", { desc = "Delete current obsidian note" })
