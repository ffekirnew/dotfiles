vim.pack.add({
  "https://github.com/ffekirnew/dashboard-nvim",
})

require("dashboard").setup({
  config = {
    week_header = {
      enable = true,
    },
  },
})
