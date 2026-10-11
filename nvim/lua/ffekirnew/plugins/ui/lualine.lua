vim.pack.add({
  "https://github.com/nvim-lualine/lualine.nvim",
})

require("lualine").setup({
  -- theme = "auto",
  globalstatus = false,
  options = {
    section_separators = "",
    component_separators = "",
    disabled_filetypes = {
      "NvimTree",
      "NVimTree",
    },
  },
  sections = {
    lualine_a = { "branch" },
    lualine_b = {},
    lualine_c = {
      "filename",
      "diagnostics",
    },
    lualine_x = {
      {}, --{ "filetype" },
      {},
    },
    lualine_y = {},
    lualine_z = {}, -- { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
})
