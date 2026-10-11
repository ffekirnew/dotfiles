-- Plugins are managed by vim.pack (Neovim 0.12+). Each file below declares its own
-- plugin(s) with vim.pack.add() and then configures them. Order matters: a file may
-- only use plugins declared by files loaded before it.

-- Build steps. Must be registered before the first vim.pack.add() so they run on install.
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if kind ~= "install" and kind ~= "update" then
      return
    end

    if name == "telescope-fzf-native.nvim" then
      vim.system({ "make" }, { cwd = ev.data.path }):wait()
    elseif name == "LuaSnip" then
      vim.system({ "make", "install_jsregexp" }, { cwd = ev.data.path }):wait()
    elseif name == "nvim-treesitter" then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      require("nvim-treesitter").update():wait(300000)
    end
  end,
})

-- The first vim.pack.add() also installs anything missing from nvim-pack-lock.json,
-- so skip the confirmation prompt there (fresh machines, headless bootstrap).
vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim", -- lua functions that many plugins use
  "https://github.com/inkarkat/vim-ReplaceWithRegister", -- replace with register contents using motion (gr + motion)
}, { confirm = false })

for _, module in ipairs({
  "ui.colorschemes.nightfox", -- select the colorscheme from the colorschemes directory here
  "ui.nvim-web-devicons",
  "editor.treesitter",
  "editor.treesitter.nvim-treesitter-text-objects",
  "editor.luasnip",
  "editor.nvim-cmp",
  "editor.nvim-autopairs",
  "ui.nvim-tree",
  "editor.lsp.nvim-lspconfig",
  "editor.lsp.mason",
  "editor.formatting.conform",
  "editor.comment",
  "editor.nvim-surround",
  "editor.searchbox",
  "editor.render-markdown",
  "editor.symbol-usage",
  "advanced.telescope",
  "advanced.which-key",
  "advanced.vim-tmux-navigator",
  "advanced.obsidian",
  "advanced.ffnotes",
  "git.gitsigns",
  "ui.dashboard",
  "ui.dressing",
  "ui.lualine",
  "ui.colorizer",
}) do
  require("ffekirnew.plugins." .. module)
end
