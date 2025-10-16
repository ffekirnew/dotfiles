M = {}

M.notes_dir = "~/.nb"
M.sub_directories = {
  daily_notes = "/daily_notes",
  inbox = "/inbox",
  zettlekasten = "/zettelkasten",
  journal = "/journal",
  templates = "/templates",
}

local fn = vim.fn
for k, sub_dir in pairs(M.sub_directories) do
  fn.execute("mkdir -p " .. M.notes_dir .. sub_dir, "silent!")
end

return M
