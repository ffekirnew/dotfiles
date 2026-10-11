vim.pack.add({
  -- Use tagged releases for stability; drop `version` to use the `main` branch for the latest features
  { src = "https://github.com/kylechui/nvim-surround", version = vim.version.range("*") },
})

require("nvim-surround").setup()
