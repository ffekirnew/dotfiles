local definitions = require("ffekirnew.extra.keymaps.nb.definitions")
local utils = require("ffekirnew.extra.keymaps.nb.utils")

print(definitions)

local keymap = vim.keymap -- for conciseness

keymap.set("n", "<leader>n", function()
  local daily_note_path = utils.getDailyNotePath()

  vim.cmd(":tabnew Daily note" .. daily_note_path)
  vim.cmd(":edit " .. daily_note_path)
  vim.fn.execute("nb import " .. daily_note_path, "silent!")
end, { desc = "Create a new daily note in a new tab" })

keymap.set("n", "<leader>ns", function()
  vim.cmd(":tabnew Find notes")
  vim.cmd(':Telescope find_files search_dirs={"' .. definitions.notes_dir .. '"}<cr>')
end, { desc = "Find and open notes in a new tab" })
