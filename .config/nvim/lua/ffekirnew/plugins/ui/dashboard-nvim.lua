return {
  "ffekirnew/dashboard-nvim",
  lazy = true,
  event = "VimEnter",
  config = function()
    require("dashboard").setup({
      config = {
        week_header = {
          enable = true,
        },
      },
    })
  end,
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
