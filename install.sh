#!/usr/bin/env bash
set -euo pipefail

# ══════════════════════════════════════════════════════════
# Cursor / VSCode + vscode-neovim 一键配置脚本
# 用法: ./install.sh [cursor|code]
# ══════════════════════════════════════════════════════════

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
IDE="${1:-cursor}"

# ── 检测平台 ──
OS="$(uname -s)"
case "$OS" in
  Darwin)
    if [[ "$IDE" == "cursor" ]]; then
      SETTINGS_DIR="$HOME/Library/Application Support/Cursor/User"
      CLI_CMD="cursor"
    else
      SETTINGS_DIR="$HOME/Library/Application Support/Code/User"
      CLI_CMD="code"
    fi
    ;;
  Linux)
    if [[ "$IDE" == "cursor" ]]; then
      SETTINGS_DIR="$HOME/.config/Cursor/User"
      CLI_CMD="cursor"
    else
      SETTINGS_DIR="$HOME/.config/Code/User"
      CLI_CMD="code"
    fi
    ;;
  *)
    echo "❌ Unsupported platform: $OS"
    exit 1
    ;;
esac

NVIM_CONFIG_DIR="$HOME/.config/nvim/lua/config"

echo "══════════════════════════════════════════════════════════"
echo "  IDE: $IDE | Platform: $OS"
echo "  Settings → $SETTINGS_DIR"
echo "  Neovim   → $NVIM_CONFIG_DIR"
echo "══════════════════════════════════════════════════════════"

# ── Step 1: 安装字体 ──
echo ""
echo "▶ Step 1: Installing fonts..."
if command -v brew &>/dev/null; then
  brew install --cask font-maple-mono font-victor-mono font-jetbrains-mono 2>/dev/null || true
  echo "  ✓ Fonts installed (or already present)"
else
  echo "  ⚠ Homebrew not found. Please install fonts manually:"
  echo "    - Maple Mono: https://github.com/subframe7536/maple-font"
  echo "    - Victor Mono: https://rubjo.github.io/victor-mono/"
  echo "    - JetBrains Mono: https://www.jetbrains.com/lp/mono/"
fi

# ── Step 2: 安装 Neovim ──
echo ""
echo "▶ Step 2: Checking Neovim..."
if command -v nvim &>/dev/null; then
  echo "  ✓ Neovim found: $(nvim --version | head -1)"
else
  echo "  Installing Neovim..."
  if command -v brew &>/dev/null; then
    brew install neovim
  else
    echo "  ⚠ Please install Neovim manually: https://neovim.io"
  fi
fi

# ── Step 3: 安装扩展 ──
echo ""
echo "▶ Step 3: Installing extensions..."
if command -v "$CLI_CMD" &>/dev/null; then
  EXTENSIONS=(
    # Theme & Icons
    "dracula-theme.theme-dracula"
    "nickcernis.jetbrains-icon-theme-2024"
    "antfu.icons-carbon"
    # Neovim
    "asvetliakov.vscode-neovim"
    # Git
    "eamodio.gitlens"
    # Diagnostics
    "usernamehw.errorlens"
    # Formatters
    "esbenp.prettier-vscode"
    "dbaeumer.vscode-eslint"
    # Languages
    "Vue.volar"
    "golang.go"
    "redhat.vscode-yaml"
  )
  for ext in "${EXTENSIONS[@]}"; do
    echo "  Installing $ext..."
    "$CLI_CMD" --install-extension "$ext" --force 2>/dev/null || true
  done
  echo "  ✓ Extensions installed"
else
  echo "  ⚠ '$CLI_CMD' CLI not found. Install extensions manually in the IDE."
fi

# ── Step 4: 复制配置文件 ──
echo ""
echo "▶ Step 4: Copying config files..."

# Cursor/VSCode settings
mkdir -p "$SETTINGS_DIR"

if [[ -f "$SETTINGS_DIR/settings.json" ]]; then
  cp "$SETTINGS_DIR/settings.json" "$SETTINGS_DIR/settings.json.bak"
  echo "  ✓ Backed up existing settings.json → settings.json.bak"
fi
cp "$SCRIPT_DIR/cursor-config/settings.json" "$SETTINGS_DIR/settings.json"
echo "  ✓ settings.json"

if [[ -f "$SETTINGS_DIR/keybindings.json" ]]; then
  cp "$SETTINGS_DIR/keybindings.json" "$SETTINGS_DIR/keybindings.json.bak"
  echo "  ✓ Backed up existing keybindings.json → keybindings.json.bak"
fi
cp "$SCRIPT_DIR/cursor-config/keybindings.json" "$SETTINGS_DIR/keybindings.json"
echo "  ✓ keybindings.json"

# Neovim config
mkdir -p "$NVIM_CONFIG_DIR"

for f in keymaps.lua lazy.lua options.lua; do
  if [[ -f "$NVIM_CONFIG_DIR/$f" ]]; then
    cp "$NVIM_CONFIG_DIR/$f" "$NVIM_CONFIG_DIR/${f}.bak"
    echo "  ✓ Backed up existing $f → ${f}.bak"
  fi
  cp "$SCRIPT_DIR/nvim-config/$f" "$NVIM_CONFIG_DIR/$f"
  echo "  ✓ $f"
done

# .prettierrc
if [[ -f "$HOME/.prettierrc" ]]; then
  cp "$HOME/.prettierrc" "$HOME/.prettierrc.bak"
  echo "  ✓ Backed up existing .prettierrc → .prettierrc.bak"
fi
cp "$SCRIPT_DIR/.prettierrc" "$HOME/.prettierrc"
echo "  ✓ .prettierrc"

# ── Done ──
echo ""
echo "══════════════════════════════════════════════════════════"
echo "  ✅ Done! Restart $IDE to apply all changes."
echo ""
echo "  ⚠ 可能需要手动调整:"
echo "    1. settings.json 中的 http.proxy（按需取消注释）"
echo "    2. go.alternateTools.dlv 路径（运行 which dlv 确认）"
echo "    3. vscode-neovim.neovimExecutablePaths（运行 which nvim 确认）"
echo "══════════════════════════════════════════════════════════"
