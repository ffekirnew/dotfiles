return {
  {
    "ribru17/bamboo.nvim",
    config = function()
      require("bamboo").setup({
        transparent = false,
        styles = {
          comments = { italic = true },
          functions = { italic = false },
          variables = { italic = false },
          keywords = { italic = false },
        },
        highlights = {},
      })
    end,
  },
}
