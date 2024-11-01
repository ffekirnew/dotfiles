return {
  {
    "nyoom-engineering/oxocarbon.nvim",

    priority = 1000, -- make sure to load this before all the other start plugins

    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme oxocarbon]])
    end,
  },
}
