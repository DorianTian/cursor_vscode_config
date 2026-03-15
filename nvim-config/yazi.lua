-- yazi.nvim: terminal file manager with preview (markdown/image/video)
-- <leader>e = snacks explorer (sidebar), <leader>fy = yazi (full preview)
if vim.g.vscode then
  return {}
end

return {
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    dependencies = { "folke/snacks.nvim" },
    keys = {
      { "<leader>fy", "<cmd>Yazi<cr>", desc = "Yazi (current file dir)" },
      { "<leader>fY", "<cmd>Yazi cwd<cr>", desc = "Yazi (project root)" },
    },
    opts = {
      open_for_directories = false,
      floating_window_scaling_factor = 0.85,
      yazi_floating_window_border = "rounded",
    },
  },
}
