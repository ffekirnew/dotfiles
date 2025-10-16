local definitions = require("ffekirnew.extra.keymaps.nb.definitions")

M = {}

M.getDailyNotePath = function()
  local now = os.date("*t")

  local date = now.year .. now.month .. now.day
  return definitions.notes_dir .. definitions.sub_directories.daily_notes .. "/" .. date .. ".md"
end

return M
