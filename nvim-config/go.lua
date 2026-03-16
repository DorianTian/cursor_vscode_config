return {
  -- Go 增强（struct tag 生成、接口实现、测试生成等）
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    build = function()
      vim.cmd([[silent! GoInstallDeps]])
    end,
    opts = {},
  },
}
