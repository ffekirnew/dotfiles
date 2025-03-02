local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { import = "ffekirnew.plugins" },
  { import = "ffekirnew.plugins.ai" },
  { import = "ffekirnew.plugins.advanced" },
  { import = "ffekirnew.plugins.editor" },
  { import = "ffekirnew.plugins.editor.lsp" },
  { import = "ffekirnew.plugins.editor.linting" },
  { import = "ffekirnew.plugins.editor.formatting" },
  { import = "ffekirnew.plugins.editor.treesitter" },
  { import = "ffekirnew.plugins.git" },
  { import = "ffekirnew.plugins.terminals" },
  { import = "ffekirnew.plugins.ui" },

  -- Select and set colorscheme from the colorschemes directory here
  { import = "ffekirnew.plugins.ui.colorschemes.nightfox" },
}, {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})
