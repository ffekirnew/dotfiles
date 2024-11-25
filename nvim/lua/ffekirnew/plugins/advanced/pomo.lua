return {
  "epwalsh/pomo.nvim",
  version = "*", -- Recommended, use latest release instead of latest commit
  lazy = true,
  cmd = { "TimerStart", "TimerRepeat", "TimerSession" },
  dependencies = {
    "rcarriga/nvim-notify",
  },
  config = function()
    require("pomo").setup({
      sessions = {
        pomodoro = {
          { name = "Work", duration = "25m" },
          { name = "Short Break", duration = "5m" },
          { name = "Work", duration = "25m" },
          { name = "Short Break", duration = "5m" },
          { name = "Work", duration = "25m" },
          { name = "Long Break", duration = "15m" },
        },

        deepwork = {
          { name = "Work", duration = "30m" },
          { name = "Short Break", duration = "6m" },
          { name = "Work", duration = "30m" },
          { name = "Short Break", duration = "6m" },
          { name = "Work", duration = "30m" },
          { name = "Long Break", duration = "15m" },
        },
      },
    })

    -- Keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>pt", "<cmd>TimerSession deepwork<cr>", { desc = "Start deep work pomodoro session" })
    keymap.set("n", "<leader>ph", "<cmd>TimerHide<cr>", { desc = "Hide Timer" })
  end,
}
