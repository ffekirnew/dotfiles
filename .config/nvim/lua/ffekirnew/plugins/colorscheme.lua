return {
  {
    "Alexis12119/nightly.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("nightly").setup({
        transparent = false,
        styles = {
          comments = { italic = true },
          functions = { italic = false },
          variables = { italic = false },
          keywords = { italic = false },
        },
        highlights = {},
      })
      -- load the colorscheme here
      vim.cmd([[colorscheme nightly]])
    end,
  },
}
