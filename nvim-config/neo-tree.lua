return {
  -- disable neo-tree and snacks explorer, use yazi.nvim instead
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },

  -- snacks: keep picker/notifications, disable explorer (replaced by yazi.nvim)
  {
    "folke/snacks.nvim",
    opts = {
      explorer = { enabled = false },
      picker = {
        sources = {
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
