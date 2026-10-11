vim.pack.add({
  "https://github.com/Wansmer/symbol-usage.nvim",
})

require("symbol-usage").setup({
  ---@type table<string, any> `nvim_set_hl`-like options for highlight virtual text
  hl = { link = "Comment" },

  ---@type 'above'|'end_of_line'|'textwidth' above by default
  vt_position = "end_of_line",

  ---Text to display when request is pending. If `false`, extmark will not be
  ---created until the request is finished. Recommended to use with `above`
  ---vt_position to avoid "jumping lines".
  ---@type string|table|false
  request_pending_text = "loading...",

  ---@type 'start'|'end' At which position of `symbol.selectionRange` the request to the lsp server should start. Default is `end` (try changing it to `start` if the symbol counting is not correct).
  symbol_request_pos = "end", -- Recommended redifine only in `filetypes` override table
})
