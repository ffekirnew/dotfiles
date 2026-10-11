vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  "https://github.com/windwp/nvim-ts-autotag",
  "https://github.com/JoosepAlviste/nvim-ts-context-commentstring",
})

local parsers = {
  "json",
  "javascript",
  "typescript",
  "tsx",
  "yaml",
  "html",
  "css",
  "markdown",
  "markdown_inline",
  "graphql",
  "bash",
  "lua",
  "vim",
  "dockerfile",
  "gitignore",
  "query",
  "python",
  "c_sharp",
  "go",
  "make",
  "cpp",
}

-- Installs missing parsers in the background. Building them needs the tree-sitter CLI
-- (see requirements.txt); without it, skip instead of erroring on every startup.
-- Headless runs (bootstrap) wait so the install finishes before exiting.
if vim.fn.executable("tree-sitter") == 1 then
  local install = require("nvim-treesitter").install(parsers)
  if #vim.api.nvim_list_uis() == 0 then
    install:wait(300000)
  end
end

-- highlight + indent for every filetype that has a parser
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("ffekirnew_treesitter", { clear = true }),
  callback = function(ev)
    if pcall(vim.treesitter.start, ev.buf) then
      vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

-- incremental selection, using Neovim's built-in treesitter node selection (v_an / v_in)
vim.keymap.set("n", "<C-space>", "van", { remap = true, desc = "Start treesitter node selection" })
vim.keymap.set("x", "<C-space>", "an", { remap = true, desc = "Expand selection to parent node" })
vim.keymap.set("x", "<bs>", "in", { remap = true, desc = "Shrink selection to child node" })

require("nvim-ts-autotag").setup()

require("ts_context_commentstring").setup({
  enable_autocmd = false,
})
