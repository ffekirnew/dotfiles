return {
  "zbirenbaum/copilot.lua",
  lazy = true,
  event = "InsertEnter",
  opts = {
    -- Possible configurable fields can be found on:
    -- https://github.com/zbirenbaum/copilot.lua#setup-and-configuration
    suggestion = {
      enable = false,
      keymap = {
        accept = "<C-l>",
      },
    },
    panel = {
      enable = false,
    },
    filetypes = {
      markdown = true,
    },
  },
}
