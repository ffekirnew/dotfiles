return {
  "https://gitlab.com/itaranto/preview.nvim",
  version = "*",

  config = function()
    local preview = require("preview")

    preview.setup({
      previewers_by_ft = {
        plantuml = {
          name = "plantuml_svg",
          renderer = { type = "imv" },
        },
      },
      previewers = {
        plantuml_svg = {
          args = { "-pipe", "-tpng" },
        },
      },
      render_on_write = true,
    })
  end,
}
