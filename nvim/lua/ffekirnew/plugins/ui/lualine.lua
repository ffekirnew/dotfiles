return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count

    require("lualine").setup({
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
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
          },
          { "fileformat" },
          { "filetype" },
        },
      },
    })
  end,
}
