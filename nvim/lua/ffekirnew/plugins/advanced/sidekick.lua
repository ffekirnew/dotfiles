vim.pack.add({
  "https://github.com/folke/sidekick.nvim",
})

require("sidekick").setup({
  -- Next Edit Suggestions need a Copilot subscription
  nes = { enabled = false },
  cli = {
    -- keep agent sessions alive across nvim restarts (only when running inside tmux)
    mux = { backend = "tmux", enabled = true },
  },
})

-- set keymaps
local keymap = vim.keymap -- for conciseness
local cli = require("sidekick.cli")

keymap.set({ "n", "t", "i", "x" }, "<C-.>", function()
  cli.focus()
end, { desc = "Sidekick: focus agent CLI" })
keymap.set("n", "<leader>aa", function()
  cli.toggle()
end, { desc = "Sidekick: toggle agent CLI" })
keymap.set("n", "<leader>as", function()
  cli.select()
end, { desc = "Sidekick: select agent CLI" })
keymap.set({ "n", "x" }, "<leader>at", function()
  cli.send({ msg = "{this}" })
end, { desc = "Sidekick: send this" })
keymap.set("x", "<leader>av", function()
  cli.send({ msg = "{selection}" })
end, { desc = "Sidekick: send selection" })
keymap.set("n", "<leader>af", function()
  cli.send({ msg = "{file}" })
end, { desc = "Sidekick: send file" })
keymap.set({ "n", "x" }, "<leader>ap", function()
  cli.prompt()
end, { desc = "Sidekick: select prompt" })
