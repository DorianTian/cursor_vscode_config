return {
  -- disable neo-tree, use snacks explorer instead
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },

  -- snacks: explorer sidebar + show dotfiles everywhere
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
          },
          files = {
            hidden = true,
            ignored = true,
          },
          grep = {
            hidden = true,
            ignored = true,
          },
          grep_word = {
            hidden = true,
            ignored = true,
          },
        },
      },
    },
  },
}
