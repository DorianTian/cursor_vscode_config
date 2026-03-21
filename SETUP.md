# Mac 环境配置指南

> 适用于新 Mac 或已有配置的 Mac。所有配置 repo 统一放在 `~/dev-env/`，脱离 iCloud。

## 前置条件

- Git + SSH key 已配置（能访问 GitHub）
- Homebrew 已安装

## 第一步：Clone 所有 repos

```bash
mkdir -p ~/dev-env && cd ~/dev-env

git clone git@github.com:DorianTian/dotfiles.git
git clone git@github.com:DorianTian/claude_setting.git
git clone git@github.com:DorianTian/skills_repo.git
git clone git@github.com:DorianTian/claude_plugins.git claude-plugins
```

> 如果 iCloud 之前同步过旧的 `~/Desktop/workspace/dotfiles` 等目录，可以直接删掉，以 `~/dev-env/` 为准。

## 第二步：安装 dotfiles

```bash
cd ~/dev-env/dotfiles
./install.sh all
```

这会：
- 安装字体、Neovim、Ghostty、Yazi 等工具（如未安装）
- 安装 Cursor/VSCode 扩展
- **symlink** nvim / ghostty / yazi / cursor / formatter 配置到 repo
- **copy** .zshrc 到 `~/`（不是 symlink，每台机器可以有自己的定制）
- **symlink** .p10k.zsh 到 repo
- 创建 `~/.zshrc.local` 模板（如果不存在）

### 重要：安装后必做

1. **编辑 `~/.zshrc.local`**，参考之前的 `.zshrc.bak` 或主力 Mac 的 `~/.zshrc.local`，填入这台机器的：
   - PATH（Go、PostgreSQL、MySQL 等）
   - Proxy 设置
   - 项目别名（AWS SSH 等）

2. **检查 .zshrc 差异**（如果之前有自己的 .zshrc）：
   ```bash
   diff ~/.zshrc.bak ~/.zshrc
   ```
   把旧 .zshrc 中 repo 版本没有的自定义内容补进 `~/.zshrc.local` 或 `~/.zshrc`。

3. **重启终端**验证一切正常。

## 第三步：安装 Claude Code Skills

```bash
cd ~/dev-env/skills_repo
./setup.sh
```

## 第四步：安装 Claude Code Plugins

```bash
cd ~/dev-env/claude-plugins
./setup.sh
```

## 第五步：安装 Claude Code Settings

```bash
cd ~/dev-env/claude_setting
./install.sh
```

## 日常同步

配置在某台 Mac 上改了之后：

```bash
# 改动的那台 Mac
cd ~/dev-env/dotfiles
git add -A && git commit -m "update: xxx" && git push

# 另一台 Mac
cd ~/dev-env/dotfiles
git pull
./install.sh nvim ghostty yazi formatters editor   # 重建 symlink（如果有新文件）
```

**注意：** `.zshrc` 是 copy 不是 symlink，`git pull` 后不会自动更新。如果 repo 里的 .zshrc 有改动，需要手动处理：
```bash
diff ~/.zshrc ~/dev-env/dotfiles/zsh-config/.zshrc   # 看差异
cp ~/dev-env/dotfiles/zsh-config/.zshrc ~/.zshrc      # 确认后覆盖
```

## 配置策略速查

| 文件 | 方式 | 原因 |
|------|------|------|
| nvim / ghostty / yazi / cursor / formatters | symlink | 各机器一致 |
| .p10k.zsh | symlink | 各机器一致 |
| .zshrc | copy | 每台机器可能有定制 |
| .zshrc.local | 本地维护 | machine-specific（PATH/proxy） |
| .vim-tips.txt | copy | 被 .zshrc 引用 |
