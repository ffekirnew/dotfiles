return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count

    require("lualine").setup({
      -- theme = "auto",
      globalstatus = false,
      options = {
        section_separators = "",
        component_separators = "",
        disabled_filetypes = {
          "NvimTree",
          "NVimTree",
          "Avante",
          "AvanteInput",
          "AvanteSelectedFiles",
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { "filename", "diagnostics" },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
          },
          { "filetype" },
          {},
        },
        lualine_y = {
          {
            function()
              local ok, pomo = pcall(require, "pomo")
              if not ok then
                return ""
              end

              local timer = pomo.get_first_to_finish()
              if timer == nil then
                return ""
              end

              return "󰄉 " .. tostring(timer)
            end,
          },
        },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
