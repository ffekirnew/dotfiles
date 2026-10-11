vim.pack.add({
  { src = "https://github.com/obsidian-nvim/obsidian.nvim", version = vim.version.range("3") },
})

local obsidian = require("obsidian")
-- Vault location comes from $NOTES_DIR (set in .zshrc) so it works on any machine
local notes_dir = vim.env.NOTES_DIR or vim.fn.expand("~/personal/notes")
obsidian.setup({
  legacy_commands = false, -- `:Obsidian new` instead of `:ObsidianNew`
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

  templates = {
    folder = "templates",
    date_format = "%Y-%m-%d",
    time_format = "%H:%M:%S",
  },

  daily_notes = {
    folder = "notes/daily-notes",
    default_tags = { "daily-notes" },
    -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
    template = "daily-note.md",
  },

  frontmatter = {
    func = function(note)
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
  },

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

  -- completion comes from the built-in obsidian-ls LSP server, so blink.cmp picks it up
  completion = {
    min_chars = 2,
  },

  -- keep the old toggle order: [ ] -> [x] (the fork defaults to [ ] -> [~])
  checkbox = {
    order = { " ", "x", ">", "~", "!" },
  },

  callbacks = {
    enter_note = function()
      -- follow markdown/wiki links within your vault
      vim.keymap.set("n", "<leader>of", "<cmd>Obsidian follow_link<cr>", { buffer = true, desc = "Follow obsidian link" })
      vim.keymap.set("n", "<leader>ch", "<cmd>Obsidian toggle_checkbox<cr>", { buffer = true, desc = "Toggle checkbox" })
    end,
  },
})

-- set keymaps
local keymap = vim.keymap -- for conciseness
keymap.set(
  "n",
  "<leader>on",
  "<cmd>:tabnew New Note | Obsidian new<cr>",
  { desc = "Create a new obsidian note in a new tab" }
)
keymap.set(
  "n",
  "<leader>ot",
  "<cmd>:tabnew New Note | Obsidian new_from_template<cr>",
  { desc = "Create a new obsidian note from template in a new tab" }
)
keymap.set(
  "n",
  "<leader>od",
  "<cmd>:tabnew New Daily Note | Obsidian today<cr>",
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
