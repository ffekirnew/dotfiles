vim.pack.add({
  "https://github.com/MeanderingProgrammer/render-markdown.nvim",
})

require("render-markdown").setup({
  code = {
    enabled = true,
    -- Turn on / off any sign column related rendering
    sign = false,
    style = "full", -- [none, normal, language, full]
    position = "left", -- [left, right]
    language_pad = 0,
    language_name = true,
    disable_background = { "diff" },
    width = "full", -- [block, full]
    left_margin = 0,
    left_pad = 0,
    right_pad = 0,
    min_width = 0.5,
    border = "thin", -- [thin, thick]
    above = "▄",
    below = "▀",
    highlight = "RenderMarkdownCode",
    highlight_inline = "RenderMarkdownCodeInline",
    highlight_language = nil,
  },
})
