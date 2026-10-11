vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
})

require("nvim-treesitter-textobjects").setup({
  move = {
    set_jumps = true, -- whether to set jumps in the jumplist
  },
})

local keymap = vim.keymap -- for conciseness
local move = require("nvim-treesitter-textobjects.move")
local swap = require("nvim-treesitter-textobjects.swap")
local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

-- Select textobjects (a=, i=, a:, af, im, ...) are intentionally not mapped.
-- The custom @property captures live in after/queries/ecma/textobjects.scm.

-- swap with previous
keymap.set("n", "<leader>pa", function()
  swap.swap_previous("@parameter.inner")
end, { desc = "Swap parameter/argument with previous" })
keymap.set("n", "<leader>p:", function()
  swap.swap_previous("@property.outer")
end, { desc = "Swap object property with previous" })
keymap.set("n", "<leader>pm", function()
  swap.swap_previous("@function.outer")
end, { desc = "Swap function with previous" })

-- { lhs, query, query_group, desc }
local moves = {
  goto_next_start = {
    { "]f", "@call.outer", "textobjects", "Next function call start" },
    { "]m", "@function.outer", "textobjects", "Next method/function def start" },
    { "]c", "@class.outer", "textobjects", "Next class start" },
    { "]i", "@conditional.outer", "textobjects", "Next conditional start" },
    { "]l", "@loop.outer", "textobjects", "Next loop start" },
    -- query groups other than textobjects come from queries/<lang>/<group>.scm (here locals.scm and folds.scm)
    { "]s", "@local.scope", "locals", "Next scope" },
    { "]z", "@fold", "folds", "Next fold" },
  },
  goto_next_end = {
    { "]F", "@call.outer", "textobjects", "Next function call end" },
    { "]M", "@function.outer", "textobjects", "Next method/function def end" },
    { "]C", "@class.outer", "textobjects", "Next class end" },
    { "]I", "@conditional.outer", "textobjects", "Next conditional end" },
    { "]L", "@loop.outer", "textobjects", "Next loop end" },
  },
  goto_previous_start = {
    { "[f", "@call.outer", "textobjects", "Prev function call start" },
    { "[m", "@function.outer", "textobjects", "Prev method/function def start" },
    { "[c", "@class.outer", "textobjects", "Prev class start" },
    { "[i", "@conditional.outer", "textobjects", "Prev conditional start" },
    { "[l", "@loop.outer", "textobjects", "Prev loop start" },
  },
  goto_previous_end = {
    { "[F", "@call.outer", "textobjects", "Prev function call end" },
    { "[M", "@function.outer", "textobjects", "Prev method/function def end" },
    { "[C", "@class.outer", "textobjects", "Prev class end" },
    { "[I", "@conditional.outer", "textobjects", "Prev conditional end" },
    { "[L", "@loop.outer", "textobjects", "Prev loop end" },
  },
}

for fn, maps in pairs(moves) do
  for _, m in ipairs(maps) do
    keymap.set({ "n", "x", "o" }, m[1], function()
      move[fn](m[2], m[3])
    end, { desc = m[4] })
  end
end

-- vim way: ; goes to the direction you were moving.
keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
