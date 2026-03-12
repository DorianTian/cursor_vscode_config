-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local opt = vim.opt

-- 三端通用选项
opt.tabstop = 2
opt.shiftwidth = 2
opt.relativenumber = true
opt.scrolloff = 8
opt.clipboard = "unnamedplus"
opt.wrap = false
opt.undofile = true

if vim.g.vscode then
  -- VSCode/Cursor 环境下不需要这些
  opt.undofile = false
end
