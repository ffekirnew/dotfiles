vim.pack.add({
  "https://github.com/rafamadriz/friendly-snippets", -- useful snippets
  -- pinned to releases so blink downloads its prebuilt fuzzy matcher
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1") },
})

require("blink.cmp").setup({
  keymap = {
    preset = "none",
    ["<S-Tab>"] = { "select_prev", "fallback" }, -- previous suggestion
    ["<Tab>"] = { "select_next", "fallback" }, -- next suggestion
    ["<C-k>"] = { "scroll_documentation_up", "fallback" },
    ["<C-j>"] = { "scroll_documentation_down", "fallback" },
    ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" }, -- show completion suggestions
    ["<C-e>"] = { "hide", "fallback" }, -- close completion window
    ["<CR>"] = { "accept", "fallback" },
  },
  completion = {
    list = { selection = { preselect = false, auto_insert = true } },
    documentation = { auto_show = true },
    accept = { auto_brackets = { enabled = true } },
  },
  -- LuaSnip is set up in editor/luasnip.lua
  snippets = { preset = "luasnip" },
  -- sources for autocompletion
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
})
