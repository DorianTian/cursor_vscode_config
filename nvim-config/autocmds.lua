-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- 防止在 home 等大目录启动 nvim 时 LSP 爆内存
local dangerous_dirs = {
  vim.fn.expand("~"),
  "/",
  "/tmp",
  "/Users",
}

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local cwd = vim.fn.getcwd()
    for _, dir in ipairs(dangerous_dirs) do
      if cwd == dir then
        vim.notify(
          "⚠️  nvim 在大目录 [" .. cwd .. "] 启动，已自动禁用 LSP 防止内存爆炸。\n请 cd 到具体项目再打开 nvim。",
          vim.log.levels.WARN
        )
        -- 停止所有已启动的 LSP
        vim.defer_fn(function()
          vim.cmd("LspStop")
        end, 1000)
        return
      end
    end
  end,
})
