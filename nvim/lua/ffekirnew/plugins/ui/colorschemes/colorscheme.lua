return {
  {
    -- "bluz71/vim-nightfly-guicolors", -- nightfly
    -- "EdenEast/nightfox.nvim", -- nightfox
    -- "catppuccin/nvim", as = "catppuccin", -- catppuccin
    -- "olivercederborg/poimandres.nvim", -- poimandres
    -- "nyoom-engineering/oxocarbon.nvim", --oxocarbon
    -- "ajgrf/parchment", -- parchment
    -- "therubymug/vim-pyte", -- pyte
    -- "rflban/homecolors.vim", -- home
    -- "rose-pine/neovim",
    -- as = "rose-pine", -- rose-pine

    priority = 1000, -- make sure to load this before all the other start plugins

    config = function()
      -- load the colorscheme here
      -- vim.cmd([[colorscheme rose-pine]])
    end,
  },
}
