---
name: setup-vscode-neovim
description: Use when setting up a new Cursor or VSCode environment - configures complete editor appearance (theme, fonts, UX) and vscode-neovim with unified keybindings across Neovim, Cursor, and VSCode. Trigger words - setup cursor, configure vim, cursor config, vscode neovim, new machine setup
---

# Cursor + VSCode-Neovim Complete Setup

One-command setup for a production-grade Cursor/VSCode environment: Dracula theme + unified Vim keybindings across Neovim / Cursor / VSCode.

## Architecture

```
Cursor/VSCode
├── settings.json           →  外观 + 行为 + 格式化 + 扩展配置
├── keybindings.json        →  Ctrl/Alt 组合键（VSCode 层直接处理）
~/.config/nvim/lua/config/
├── lazy.lua                →  VSCode 模式只加载 surround，Neovim 加载全部
├── keymaps.lua             →  vim.g.vscode 分支：80+ 统一快捷键
└── options.lua             →  三端共享选项
~/.prettierrc               →  全局 Prettier 配置
```

## Key Design Decisions

1. **两层键绑定**：`<leader>` 键在 keymaps.lua（neovim 层），`Ctrl/Alt` 组合键在 keybindings.json（VSCode 层，因为 VSCode/macOS 会拦截）
2. **双 API 模式**：`vim.fn.VSCodeNotify`（始终可用，无参数）+ `require("vscode").action`（pcall 保护，支持传参）
3. **macOS Alt 死键**：`Alt+j/k` 必须在 keybindings.json 绑定，因为 macOS 会将 Alt+key 转为特殊字符
4. **不用 neovimClean**：会跳过 init.lua，导致所有 keymaps 和 formatOnSave 失效

## Step 1: Install Fonts

```bash
brew install --cask font-maple-mono font-victor-mono font-jetbrains-mono
```

## Step 2: Install Extensions

```bash
# Theme & Icons
cursor --install-extension dracula-theme.theme-dracula
cursor --install-extension nickcernis.jetbrains-icon-theme-2024
cursor --install-extension antfu.icons-carbon

# Neovim
cursor --install-extension asvetliakov.vscode-neovim

# Essential
cursor --install-extension eamodio.gitlens
cursor --install-extension usernamehw.errorlens
cursor --install-extension esbenp.prettier-vscode
cursor --install-extension dbaeumer.vscode-eslint
cursor --install-extension Vue.volar
cursor --install-extension golang.go
cursor --install-extension redhat.vscode-yaml
```

## Step 3: Write Config Files

### Paths

| File | macOS Cursor | macOS VSCode |
|------|-------------|-------------|
| settings.json | `~/Library/Application Support/Cursor/User/` | `~/Library/Application Support/Code/User/` |
| keybindings.json | same | same |
| Neovim config | `~/.config/nvim/lua/config/` | same |
| Prettier | `~/.prettierrc` | same |

### settings.json Key Points

- Theme: `"Dracula Theme"` (not `"Dracula"`)
- Icons: `"vscode-jetbrains-icon-theme"`
- Font: `"'Maple Mono', 'Victor Mono', ..."` at 16px
- `tokenColorCustomizations` scope must match: `"[Dracula Theme]"`
- NO `editor.cursorSurroundingLines` (causes viewport jumping)
- NO `neovimClean: true` (kills all keymaps)
- `keyboard.dispatch: "keyCode"` (important for non-US keyboards)
- `extensions.experimental.affinity` gives neovim extension dedicated thread

### keybindings.json Key Points

- `Ctrl+h/j/k/l` → `workbench.action.focus*Group` (not `navigate*`)
- `when: "editorTextFocus && neovim.mode != 'insert'"`
- `Alt+j/k` → `editor.action.moveLines*Action`
- Must remove default `Ctrl+H` (Find & Replace) and `Ctrl+L` (expandLineSelection)

### keymaps.lua Key Points

- Use `vim.fn.VSCodeNotify` as primary (always available)
- Use `pcall(require, "vscode")` for `action_with_args` (supports `{ args = {...} }`)
- `<leader>sw` uses vim-native `*N` for n/N navigation
- `<leader>sg/sW` uses `action_with_args` to pass query parameter
- `[f]/]f` (treesitter function jump) has NO VSCode equivalent → use `<leader>ss` instead

## Step 4: Remove Conflicts

- Uninstall VSCodeVim (`vscodevim.vim`) if present — conflicts with vscode-neovim
- Remove any `vim.*` keys from settings.json

## Step 5: Verify

1. `Cmd+Shift+P` → `Developer: Reload Window`
2. Test `gd`, `gr`, `K` on a code symbol
3. Test `<leader>ff`, `<leader>sg`, `<leader>e`
4. Test `ys`, `ds`, `cs` (surround)
5. Test `Alt+j/k` (line move)
6. Test `Ctrl+h/j/k/l` (window navigation)

## Troubleshooting

| Issue | Fix |
|-------|-----|
| `nvim_win_set_cursor` error | `Cmd+Shift+P` → `Neovim: Restart` |
| `_getNeovimClient already exists` | Uninstall VSCodeVim |
| Leader keys not working | Ensure `neovimClean` is NOT set |
| Prettier not formatting | Ensure `neovimClean` is NOT set |
| `Ctrl+h` error "Unknown part" | Use `focusLeftGroup` not `navigateLeft` |
| `Alt+j/k` not working | Must be in keybindings.json (macOS dead keys) |
