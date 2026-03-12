# Cursor 完整配置指南

> 一流外观 + 极致 Vim 体验。三端统一：Neovim / Cursor / VSCode。

---

## Quick Start (新机器一键配置)

```bash
# 1. 安装字体
brew install --cask font-maple-mono font-victor-mono font-jetbrains-mono

# 2. 安装 Neovim
brew install neovim

# 3. 安装 Cursor 扩展
cursor --install-extension Catppuccin.catppuccin-vsc
cursor --install-extension Catppuccin.catppuccin-vsc-icons
cursor --install-extension antfu.icons-carbon
cursor --install-extension asvetliakov.vscode-neovim
cursor --install-extension eamodio.gitlens
cursor --install-extension usernamehw.errorlens

# 4. 让 Claude 自动配置
# 在 Cursor 终端中使用 Claude Code，输入 /setup-vscode-neovim
```

---

## 外观效果

| 项目 | 选择 | 理由 |
|------|------|------|
| **主题** | Catppuccin Mocha | 暖色高对比，完整生态（编辑器+图标统一风格） |
| **编辑器字体** | Maple Mono | 最佳连字 + 草书斜体（关键字/注释自动斜体） |
| **终端字体** | Maple Mono / Victor Mono | 连字支持，阅读舒适 |
| **图标** | Catppuccin Icons + Carbon Product Icons | 统一风格，文件类型一目了然 |
| **字体粗细** | 400（Regular） | Bold 全屏看久眼疲劳，用斜体做强调 |

---

## 核心配置文件

### Cursor settings.json

路径：`~/Library/Application Support/Cursor/User/settings.json`

```json
{
  // ══ 字体 ══
  "editor.fontFamily": "'Maple Mono', 'Victor Mono', 'JetBrains Mono', 'Fira Code', Menlo, monospace",
  "editor.fontSize": 15,
  "editor.fontWeight": "400",
  "editor.fontLigatures": "'calt', 'liga', 'ss01', 'ss02'",
  "editor.fontVariations": true,
  "terminal.integrated.fontFamily": "'Maple Mono', 'Victor Mono', 'JetBrains Mono'",
  "terminal.integrated.fontSize": 14,
  "terminal.integrated.fontWeightBold": "bold",
  "terminal.integrated.fontLigatures.enabled": true,
  "debug.console.fontFamily": "'Victor Mono'",
  "debug.console.fontSize": 14,
  "scm.inputFontFamily": "'Victor Mono'",
  "scm.inputFontSize": 14,
  "notebook.markup.fontFamily": "'Victor Mono'",
  "notebook.markup.fontSize": 14,
  "notebook.output.fontFamily": "'Victor Mono'",
  "notebook.output.fontSize": 14,
  "editor.inlineSuggest.fontFamily": "'Victor Mono'",
  "editor.suggestFontSize": 14,
  "errorLens.fontFamily": "'Victor Mono'",
  "errorLens.fontSize": "13",

  // ══ 主题 & 外观 ══
  "workbench.colorTheme": "Catppuccin Mocha",
  "workbench.iconTheme": "catppuccin-mocha",
  "workbench.productIconTheme": "icons-carbon",
  "workbench.sideBar.location": "right",
  "window.commandCenter": true,
  "editor.semanticHighlighting.enabled": true,
  "editor.tokenColorCustomizations": {
    "[Catppuccin Mocha]": {
      "textMateRules": [
        {
          "scope": ["comment", "keyword", "storage.modifier", "variable.language.this", "entity.other.attribute-name"],
          "settings": { "fontStyle": "italic" }
        }
      ]
    }
  },

  // ══ 编辑器体验 ══
  "editor.tabSize": 2,
  "editor.lineNumbers": "relative",
  "editor.cursorSurroundingLines": 8,
  "editor.cursorBlinking": "smooth",
  "editor.cursorSmoothCaretAnimation": "on",
  "editor.smoothScrolling": true,
  "editor.mouseWheelScrollSensitivity": 2,
  "editor.bracketPairColorization.enabled": true,
  "editor.guides.bracketPairs": "active",
  "editor.guides.indentation": true,
  "editor.guides.highlightActiveIndentation": true,
  "editor.minimap.enabled": true,
  "editor.minimap.renderCharacters": false,
  "editor.minimap.maxColumn": 80,
  "editor.minimap.autohide": true,
  "editor.stickyScroll.enabled": true,
  "editor.stickyScroll.maxLineCount": 3,
  "editor.formatOnSave": true,
  "editor.formatOnPaste": false,
  "editor.linkedEditing": true,
  "editor.renderWhitespace": "boundary",
  "editor.wordWrap": "off",
  "editor.rulers": [120],
  "editor.inlayHints.enabled": "onUnlessPressed",
  "editor.inlayHints.fontSize": 12,
  "diffEditor.ignoreTrimWhitespace": false,

  // ══ 终端 ══
  "terminal.integrated.smoothScrolling": true,
  "terminal.integrated.cursorBlinking": true,
  "terminal.integrated.cursorStyle": "line",

  // ══ Workbench 行为 ══
  "explorer.confirmDelete": false,
  "explorer.confirmDragAndDrop": false,
  "explorer.compactFolders": false,
  "workbench.editor.tabSizing": "shrink",
  "workbench.editor.enablePreview": true,
  "workbench.startupEditor": "none",
  "workbench.list.smoothScrolling": true,
  "workbench.tree.indent": 16,
  "workbench.settings.applyToAllProfiles": [],

  // ══ 语言 Formatter ══
  "[vue]": { "editor.defaultFormatter": "Vue.volar" },
  "[typescript]": { "editor.defaultFormatter": "esbenp.prettier-vscode" },
  "[typescriptreact]": { "editor.defaultFormatter": "esbenp.prettier-vscode" },
  "[javascript]": { "editor.defaultFormatter": "esbenp.prettier-vscode" },
  "[json]": { "editor.defaultFormatter": "esbenp.prettier-vscode" },
  "[jsonc]": { "editor.defaultFormatter": "vscode.json-language-features" },
  "[html]": { "editor.defaultFormatter": "esbenp.prettier-vscode" },
  "[css]": { "editor.defaultFormatter": "esbenp.prettier-vscode" },
  "[scss]": { "editor.defaultFormatter": "esbenp.prettier-vscode" },
  "[less]": { "editor.defaultFormatter": "esbenp.prettier-vscode" },
  "[yaml]": { "editor.defaultFormatter": "redhat.vscode-yaml" },
  "[sql]": { "editor.defaultFormatter": "cweijan.vscode-database-client2" },
  "[go]": {
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "golang.go",
    "editor.codeActionsOnSave": { "source.organizeImports": "explicit" }
  },

  // ══ 语言 & 工具 ══
  "go.formatTool": "goimports",
  "go.toolsManagement.autoUpdate": true,
  "go.alternateTools": { "dlv": "/opt/homebrew/bin/dlv" },
  "go.lintTool": "golangci-lint",
  "go.lintOnSave": "workspace",
  "javascript.updateImportsOnFileMove.enabled": "always",
  "typescript.updateImportsOnFileMove.enabled": "always",
  "json.schemas": [],

  // ══ Git ══
  "git.enableSmartCommit": true,
  "git.autofetch": true,
  "git.openRepositoryInParentFolders": "never",
  "gitlens.graph.layout": "editor",
  "gitlens.codeLens.enabled": false,

  // ══ 扩展 ══
  "database-client.autoSync": true,
  "redhat.telemetry.enabled": true,
  "console-ninja.featureSet": "Community",
  "console-ninja.fontSize": 14,
  "makefile.configureOnOpen": true,
  "security.promptForLocalFileProtocolHandling": false,
  "keyboard.dispatch": "keyCode",

  // ══ Claude Code ══
  "claudeCode.useTerminal": true,
  "claudeCode.environmentVariables": [],

  // ══ VSCode-Neovim ══
  "vscode-neovim.neovimExecutablePaths.darwin": "/opt/homebrew/bin/nvim",
  "extensions.experimental.affinity": {
    "asvetliakov.vscode-neovim": 1
  }
}
```

---

## Neovim 配置（三端共享）

所有文件位于 `~/.config/nvim/lua/config/`。

### options.lua

```lua
local opt = vim.opt
opt.tabstop = 2
opt.shiftwidth = 2
opt.relativenumber = true
opt.scrolloff = 8
opt.clipboard = "unnamedplus"
opt.wrap = false
opt.undofile = true
if vim.g.vscode then opt.undofile = false end
```

### lazy.lua 核心逻辑

```lua
if vim.g.vscode then
  -- 手动加载（没有 LazyVim 自动加载）
  require("config.options")
  require("lazy").setup({
    spec = {
      { "kylechui/nvim-surround", version = "*", event = "VeryLazy", opts = {} },
    },
  })
  require("config.keymaps")
else
  -- 完整 LazyVim + 所有 plugins/
  require("lazy").setup({ ... })
end
```

### keymaps.lua 核心逻辑

```lua
-- 通用
map("i", "jk", "<esc>")
map("n", ";", ":")

if vim.g.vscode then
  local vscode = require("vscode")
  -- 70+ 映射，全部走 vscode.action()
  -- ...
else
  -- 原生 Neovim 命令
  -- ...
end
```

---

## 统一快捷键速查表

> `<leader>` = 空格键

### LSP

| 快捷键 | 功能 |
|--------|------|
| `gd` | 跳转定义 |
| `gD` | Peek 定义 |
| `gr` | 查找引用 |
| `gi` | 跳转实现 |
| `gy` | 跳转类型定义 |
| `K` | 悬浮文档 |
| `]d` / `[d` | 下/上一个诊断 |

### 代码操作

| 快捷键 | 功能 |
|--------|------|
| `<leader>rn` | 重命名 |
| `<leader>ca` | 快速修复 |
| `<leader>fm` | 格式化 |

### 搜索 & 导航

| 快捷键 | 功能 |
|--------|------|
| `<leader>ff` | 搜索文件 |
| `<leader>fg` / `<leader>/` | 全局文本搜索 |
| `<leader>fw` | 搜索光标下的词 |
| `<leader>fb` | 搜索 Buffer |
| `<leader>fr` | 最近文件 |
| `<leader>e` | 切换侧边栏 |
| `<leader>E` | 定位当前文件 |

### 窗口 & Buffer

| 快捷键 | 功能 |
|--------|------|
| `Ctrl+h/j/k/l` | 窗口导航 |
| `H` / `L` | 上/下一个 Tab |
| `<leader>bd` | 关闭 Buffer |
| `<leader>1-4` | 跳转编辑器 1-4 |
| `Ctrl+\` | 切换终端 |

### Git

| 快捷键 | 功能 |
|--------|------|
| `<leader>gB` | 文件 Blame |
| `<leader>gd` | SCM / Diff |
| `<leader>gh` | 文件历史 |
| `]c` / `[c` | 下/上一个变更 |

### Debug

| 快捷键 | 功能 |
|--------|------|
| `<leader>db` | 断点 |
| `<leader>dc` | 继续 |
| `<leader>do` / `di` / `dO` | 步过 / 步入 / 步出 |
| `<leader>dt` / `dr` | 终止 / 重启 |

### Test

| 快捷键 | 功能 |
|--------|------|
| `<leader>tt` | 运行最近测试 |
| `<leader>tf` | 运行文件测试 |
| `<leader>td` | 调试测试 |

### 其他

| 快捷键 | 功能 |
|--------|------|
| `jk` | 退出 Insert |
| `;` | 命令模式 |
| `Ctrl+s` | 保存 |
| `Alt+j/k` | 移动行 |
| `ys / ds / cs` | Surround 操作 |
| `<leader>cgt` | Go: 添加 tag |
| `<leader>Dt` | 数据库面板 |

---

## 维护

- **添加快捷键**：`keymaps.lua` 的 `vim.g.vscode` 两个分支各加一份
- **添加插件**：只加到 `plugins/` 目录，VSCode 模式自动跳过
- **换主题**：改 `settings.json` 的 `colorTheme` + `iconTheme`，同时更新 `tokenColorCustomizations` 的 scope
- **换字体**：改 `editor.fontFamily`，确保已安装
