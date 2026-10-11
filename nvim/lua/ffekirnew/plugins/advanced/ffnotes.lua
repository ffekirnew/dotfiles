vim.pack.add({
  "https://github.com/ffekirnew/ffnotes-nvim",
})

local ffnotes = require("ffnotes")

ffnotes.setup({})

local keymap = vim.keymap.set
keymap("n", "<leader>nn", "<cmd>FfnotesNewNote<cr>", { desc = "New Note" })
keymap("n", "<leader>nd", "<cmd>FfnotesDailyNote<cr>", { desc = "Daily note" })
keymap("n", "<leader>ns", "<cmd>FfnotesSearchNotes<cr>", { desc = "Search notes" })
keymap("n", "<leader>nft", "<cmd>FfnotesNewNoteFromTemplate<cr>", { desc = "New note from template" })
keymap("n", "<leader>nt", "<cmd>FfnotesNewTemplate<cr>", { desc = "New template" })
