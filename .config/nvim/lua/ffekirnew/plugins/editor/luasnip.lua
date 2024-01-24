return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp", -- install jsregexp (optional!).

  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}
