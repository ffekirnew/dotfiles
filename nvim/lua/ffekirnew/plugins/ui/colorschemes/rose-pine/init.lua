return {
  "rose-pine/neovim",
  as = "rose-pine",

  priority = 1000,

  config = function()
    vim.cmd("colorscheme rose-pine") -- [rose-pine, rose-pine-main, rose-pine-moon, rose-pine-dawn]
  end,
}
