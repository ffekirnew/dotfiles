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

    keymap.set("n", "<leader>ps", "<cmd>TimerSession deepwork<cr>", { desc = "Pomo: Start deep work pomodoro session" })
    keymap.set("n", "<leader>pp", "<cmd>TimerPause<cr>", { desc = "Pomo: pause timer" })
    keymap.set("n", "<leader>pr", "<cmd>TimerResume<cr>", { desc = "Pomo: resume timer" })
    keymap.set("n", "<leader>pd", "<cmd>TimerHide<cr>", { desc = "Pomo: hide timer" })
  end,
}
