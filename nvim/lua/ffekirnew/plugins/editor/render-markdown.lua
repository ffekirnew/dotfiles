return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
  ft = { "markdown" },
  config = function()
    local render_markdown = require("render-markdown")

    render_markdown.setup({
      enabled = true,
      code = {
        enabled = true,
        sign = true,
        style = "normal",
        position = "right",
        language_pad = 0,
        language_name = true,
        disable_background = { "diff" },
        width = "block",
        left_margin = 0,
        left_pad = 0,
        right_pad = 0,
        min_width = 0,
        border = "thin",
        above = "▄",
        below = "▀",
        highlight = "RenderMarkdownCode",
        highlight_inline = "RenderMarkdownCodeInline",
        highlight_language = nil,
      },
    })
  end,
}
