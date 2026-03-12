-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = vim.keymap.set

-- ══════════════════════════════════════════════════════════
-- 通用映射（Neovim / VSCode / Cursor 三端一致）
-- ══════════════════════════════════════════════════════════

-- jk 退出插入模式
map("i", "jk", "<esc>", { desc = "Exit insert mode" })

-- ; 进入命令模式
map("n", ";", ":", { desc = "Command mode" })

if vim.g.vscode then
  -- ════════════════════════════════════════════════════════
  -- VSCode / Cursor 环境
  -- ════════════════════════════════════════════════════════
  local vscode = require("vscode")

  -- ── 行移动 ──
  map("n", "<A-j>", function() vscode.action("editor.action.moveLinesDownAction") end, { desc = "Move line down" })
  map("n", "<A-k>", function() vscode.action("editor.action.moveLinesUpAction") end, { desc = "Move line up" })
  map("v", "<A-j>", function() vscode.action("editor.action.moveLinesDownAction") end, { desc = "Move line down" })
  map("v", "<A-k>", function() vscode.action("editor.action.moveLinesUpAction") end, { desc = "Move line up" })

  -- ── 保存 ──
  map({ "n", "i", "v" }, "<C-s>", function() vscode.action("workbench.action.files.save") end, { desc = "Save file" })

  -- ── LSP 跳转 ──
  map("n", "gd", function() vscode.action("editor.action.revealDefinition") end, { desc = "Go to definition" })
  map("n", "gD", function() vscode.action("editor.action.peekDefinition") end, { desc = "Peek definition" })
  map("n", "gr", function() vscode.action("editor.action.goToReferences") end, { desc = "Go to references" })
  map("n", "gi", function() vscode.action("editor.action.goToImplementation") end, { desc = "Go to implementation" })
  map("n", "gy", function() vscode.action("editor.action.goToTypeDefinition") end, { desc = "Go to type definition" })
  map("n", "K", function() vscode.action("editor.action.showHover") end, { desc = "Hover info" })
  map("n", "<leader>rn", function() vscode.action("editor.action.rename") end, { desc = "Rename symbol" })
  map("n", "<leader>ca", function() vscode.action("editor.action.quickFix") end, { desc = "Code action" })
  map("v", "<leader>ca", function() vscode.action("editor.action.quickFix") end, { desc = "Code action" })
  map("n", "<leader>fm", function() vscode.action("editor.action.formatDocument") end, { desc = "Format document" })
  map("n", "]d", function() vscode.action("editor.action.marker.next") end, { desc = "Next diagnostic" })
  map("n", "[d", function() vscode.action("editor.action.marker.prev") end, { desc = "Prev diagnostic" })

  -- ── 文件 / 搜索（对标 Telescope）──
  map("n", "<leader>ff", function() vscode.action("workbench.action.quickOpen") end, { desc = "Find file" })
  map("n", "<leader>fg", function() vscode.action("workbench.action.findInFiles") end, { desc = "Find in files" })
  map("n", "<leader>fw", function() vscode.action("editor.action.addSelectionToNextFindMatch") end, { desc = "Find word under cursor" })
  map("n", "<leader>fb", function() vscode.action("workbench.action.showAllEditors") end, { desc = "Find buffer" })
  map("n", "<leader>fr", function() vscode.action("workbench.action.openRecent") end, { desc = "Recent files" })
  map("n", "<leader>/", function() vscode.action("workbench.action.findInFiles") end, { desc = "Search in project" })

  -- ── 文件树 / 侧边栏（对标 Neo-tree）──
  map("n", "<leader>e", function() vscode.action("workbench.action.toggleSidebarVisibility") end, { desc = "Toggle sidebar" })
  map("n", "<leader>E", function() vscode.action("workbench.files.action.showActiveFileInExplorer") end, { desc = "Reveal file in explorer" })

  -- ── 窗口导航（对标 tmux-navigator）──
  map("n", "<C-h>", function() vscode.action("workbench.action.navigateLeft") end, { desc = "Navigate left" })
  map("n", "<C-j>", function() vscode.action("workbench.action.navigateDown") end, { desc = "Navigate down" })
  map("n", "<C-k>", function() vscode.action("workbench.action.navigateUp") end, { desc = "Navigate up" })
  map("n", "<C-l>", function() vscode.action("workbench.action.navigateRight") end, { desc = "Navigate right" })

  -- ── Buffer 切换 ──
  map("n", "H", function() vscode.action("workbench.action.previousEditor") end, { desc = "Prev buffer" })
  map("n", "L", function() vscode.action("workbench.action.nextEditor") end, { desc = "Next buffer" })
  map("n", "<leader>bd", function() vscode.action("workbench.action.closeActiveEditor") end, { desc = "Close buffer" })

  -- ── Harpoon 等价（编辑器索引跳转）──
  map("n", "<leader>1", function() vscode.action("workbench.action.openEditorAtIndex1") end, { desc = "Editor 1" })
  map("n", "<leader>2", function() vscode.action("workbench.action.openEditorAtIndex2") end, { desc = "Editor 2" })
  map("n", "<leader>3", function() vscode.action("workbench.action.openEditorAtIndex3") end, { desc = "Editor 3" })
  map("n", "<leader>4", function() vscode.action("workbench.action.openEditorAtIndex4") end, { desc = "Editor 4" })

  -- ── 终端（对标 ToggleTerm）──
  map("n", "<C-\\>", function() vscode.action("workbench.action.terminal.toggleTerminal") end, { desc = "Toggle terminal" })

  -- ── Git（对标 gitsigns / diffview / neogit）──
  map("n", "<leader>gB", function() vscode.action("gitlens.toggleFileBlame") end, { desc = "Toggle file blame" })
  map("n", "<leader>gd", function() vscode.action("workbench.view.scm") end, { desc = "Source control" })
  map("n", "<leader>gp", function() vscode.action("editor.action.dirtydiff.next") end, { desc = "Next change" })
  map("n", "<leader>gh", function() vscode.action("timeline.focus") end, { desc = "File history" })
  map("n", "<leader>gn", function() vscode.action("workbench.view.scm") end, { desc = "Git status" })
  map("n", "]c", function() vscode.action("workbench.action.editor.nextChange") end, { desc = "Next git change" })
  map("n", "[c", function() vscode.action("workbench.action.editor.previousChange") end, { desc = "Prev git change" })

  -- ── Debug（对标 nvim-dap）──
  map("n", "<leader>db", function() vscode.action("editor.debug.action.toggleBreakpoint") end, { desc = "Toggle breakpoint" })
  map("n", "<leader>dB", function() vscode.action("editor.debug.action.conditionalBreakpoint") end, { desc = "Conditional breakpoint" })
  map("n", "<leader>dc", function() vscode.action("workbench.action.debug.continue") end, { desc = "Continue" })
  map("n", "<leader>do", function() vscode.action("workbench.action.debug.stepOver") end, { desc = "Step over" })
  map("n", "<leader>di", function() vscode.action("workbench.action.debug.stepInto") end, { desc = "Step into" })
  map("n", "<leader>dO", function() vscode.action("workbench.action.debug.stepOut") end, { desc = "Step out" })
  map("n", "<leader>dt", function() vscode.action("workbench.action.debug.stop") end, { desc = "Terminate" })
  map("n", "<leader>dr", function() vscode.action("workbench.action.debug.restart") end, { desc = "Restart" })
  map("n", "<leader>du", function() vscode.action("workbench.debug.action.toggleRepl") end, { desc = "Toggle REPL" })

  -- ── Test（对标 neotest）──
  map("n", "<leader>tt", function() vscode.action("testing.runAtCursor") end, { desc = "Run nearest test" })
  map("n", "<leader>tf", function() vscode.action("testing.runCurrentFile") end, { desc = "Run file tests" })
  map("n", "<leader>ts", function() vscode.action("testing.viewAsTree") end, { desc = "Test summary" })
  map("n", "<leader>td", function() vscode.action("testing.debugAtCursor") end, { desc = "Debug nearest test" })

  -- ── Database（对标 vim-dadbod）──
  map("n", "<leader>Dt", function() vscode.action("database-client.showDatabasePanel") end, { desc = "Toggle DB panel" })

  -- ── Go 专用（对标 gopher.nvim）──
  map("n", "<leader>cgt", function() vscode.action("go.add.tags") end, { desc = "Add Go tags" })
  map("n", "<leader>cgr", function() vscode.action("go.remove.tags") end, { desc = "Remove Go tags" })
  map("n", "<leader>cge", function() vscode.action("editor.action.quickFix") end, { desc = "Generate if err" })

else
  -- ════════════════════════════════════════════════════════
  -- 原生 Neovim 环境
  -- ════════════════════════════════════════════════════════

  -- 保存
  map({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

  -- Alt+j/k 移动行
  map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
  map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
  map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })
  map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
  map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move line down" })
  map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move line up" })
end
