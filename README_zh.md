# CodexBar 🎚️ — 愿你的 Token 永不耗尽。

[English](README.md) | **中文**

轻量级 macOS 14+ 菜单栏应用，实时显示 Codex、Claude、Cursor、Gemini、Antigravity、Droid (Factory)、Copilot、z.ai、Kiro、Vertex AI、Augment、Amp、JetBrains AI、OpenRouter、Perplexity 和 Abacus AI 的用量限制（部分提供商支持会话用量 + 每周用量），并显示每个窗口的重置时间。每个提供商对应一个状态项（也可启用"合并图标"模式，通过提供商切换器统一管理，并可选显示最多三个提供商的概览标签页）；在设置中按需启用所需提供商。无 Dock 图标，界面极简，菜单栏图标动态变化。

<img src="codexbar.png" alt="CodexBar 菜单截图" width="520" />

## 安装

### 系统要求
- macOS 14+（Sonoma）

### GitHub Releases
下载地址：<https://github.com/steipete/CodexBar/releases>

### Homebrew
```bash
brew install --cask steipete/tap/codexbar
```

### Linux（仅 CLI）
```bash
brew install steipete/tap/codexbar
```
或从 GitHub Releases 下载 `CodexBarCLI-v<tag>-linux-<arch>.tar.gz`。  
Linux 通过 Omarchy 支持：社区 Waybar 模块和 TUI，由 `codexbar` 可执行文件驱动。

### 首次运行
- 打开「设置 → 提供商」，启用你需要的提供商。
- 安装 / 登录你依赖的提供商源（如 `codex`、`claude`、`gemini`、浏览器 Cookie 或 OAuth；Antigravity 需要 Antigravity 应用在运行中）。
- 可选：「设置 → 提供商 → Codex → OpenAI Cookies」（自动或手动）以获取仪表盘附加信息。

## 提供商

- [Codex](docs/codex.md) — 本地 Codex CLI RPC（+ PTY 回退）及可选 OpenAI 网页仪表盘附加信息。
- [Claude](docs/claude.md) — OAuth API 或浏览器 Cookie（+ CLI PTY 回退）；会话 + 每周用量。
- [Cursor](docs/cursor.md) — 浏览器会话 Cookie，获取套餐、用量及账单重置信息。
- [Gemini](docs/gemini.md) — 基于 OAuth 的配额 API，使用 Gemini CLI 凭据（无需浏览器 Cookie）。
- [Antigravity](docs/antigravity.md) — 本地语言服务器探测（实验性）；无需外部认证。
- [Droid](docs/factory.md) — 浏览器 Cookie + WorkOS Token 流，获取 Factory 用量及账单信息。
- [Copilot](docs/copilot.md) — GitHub 设备流 + Copilot 内部用量 API。
- [z.ai](docs/zai.md) — API Token（Keychain）用于配额 + MCP 窗口。
- [Kimi](docs/kimi.md) — 认证 Token（来自 `kimi-auth` Cookie 的 JWT）用于每周配额 + 5 小时速率限制。
- [Kimi K2](docs/kimi-k2.md) — API Key 用于基于额度的用量统计。
- [Kiro](docs/kiro.md) — 通过 `kiro-cli /usage` 命令获取 CLI 用量；每月点数 + 奖励点数。
- [Vertex AI](docs/vertexai.md) — Google Cloud gcloud OAuth，通过本地 Claude 日志追踪 Token 费用。
- [Augment](docs/augment.md) — 基于浏览器 Cookie 的认证，自动保持会话活跃；点数追踪与用量监控。
- [Amp](docs/amp.md) — 基于浏览器 Cookie 的认证，追踪 Amp Free 用量。
- [JetBrains AI](docs/jetbrains.md) — 从 JetBrains IDE 配置读取本地 XML 配额；每月点数追踪。
- [OpenRouter](docs/openrouter.md) — API Token 用于跨多个 AI 提供商的额度用量追踪。
- [Abacus AI](docs/abacus.md) — 浏览器 Cookie 认证，追踪 ChatLLM/RouteLLM 计算点数。
- [DeepSeek](docs/deepseek.md) — API Key 用于余额追踪（付费余额 vs 赠送余额）。
- 欢迎新提供商：[提供商开发指南](docs/provider.md)。

## 图标与截图
菜单栏图标是一个迷你双条进度计：
- **上条**：5 小时 / 会话窗口。若每周用量缺失或已耗尽但有可用点数，则变为较粗的点数条。
- **下条**：每周窗口（细线）。
- 错误 / 数据过期时图标变暗；状态叠加层指示异常事件。

## 功能特性
- 多提供商菜单栏，每个提供商可单独开关（设置 → 提供商）。
- 会话 + 每周用量计量器，附重置倒计时。
- 可选 Codex 网页仪表盘增强（剩余代码审查次数、用量分解、积分历史）。
- Codex + Claude 本地费用扫描（最近 30 天）。
- 提供商状态轮询，菜单和图标叠加层显示事件徽章。
- 合并图标模式：将多个提供商合并为一个状态项 + 切换器，可选显示最多三个提供商的概览标签页。
- 刷新频率预设（手动、1 分钟、2 分钟、5 分钟、15 分钟）。
- 内置 CLI（`codexbar`）支持脚本和 CI 使用（含 `codexbar cost --provider codex|claude` 本地费用统计）；提供 Linux CLI 构建。
- WidgetKit 小组件镜像菜单卡片快照。
- 隐私优先：默认在设备本地解析；浏览器 Cookie 为可选功能，复用现有 Cookie（不存储密码）。

## 隐私说明
CodexBar 不会扫描你的磁盘——它不会爬取整个文件系统，仅在相关功能启用时读取少量已知位置（浏览器 Cookie / 本地存储、本地 JSONL 日志）。详见 [issue #12](https://github.com/steipete/CodexBar/issues/12) 中的讨论和审计说明。

## macOS 权限说明
- **完全磁盘访问（可选）**：仅在读取 Safari Cookie / 本地存储以用于网页端提供商（Codex Web、Claude Web、Cursor、Droid/Factory）时需要。若不授予，请改用 Chrome/Firefox Cookie 或仅使用 CLI 来源。
- **钥匙串访问（由 macOS 提示）**：
  - Chrome Cookie 导入需要「Chrome Safe Storage」密钥来解密 Cookie。
  - 若存在由 Claude CLI 写入的 Claude OAuth 凭据，CodexBar 会从钥匙串中读取。
  - z.ai API Token 通过「偏好设置 → 提供商」存储至钥匙串；Copilot 在设备流程中将 API Token 存入钥匙串。
  - **如何避免钥匙串弹窗？**
    - 打开「钥匙串访问.app」→ 登录钥匙串 → 搜索对应条目（如「Claude Code-credentials」）。
    - 打开该条目 → **访问控制** → 在「始终允许访问此项目的应用程序」中添加 `CodexBar.app`。
    - 建议仅添加 CodexBar（避免使用「允许所有应用程序」，除非你希望完全开放）。
    - 保存后重新启动 CodexBar。
    - 参考截图：![钥匙串访问控制](docs/keychain-allow.png)
  - **浏览器同理**：
    - 找到浏览器的「Safe Storage」条目（如「Chrome Safe Storage」、「Brave Safe Storage」、「Firefox」、「Microsoft Edge Safe Storage」）。
    - 打开该条目 → **访问控制** → 添加 `CodexBar.app`。
    - 此后 CodexBar 解密该浏览器的 Cookie 时将不再弹出提示。
- **文件与文件夹提示（文件夹 / 卷访问）**：CodexBar 会启动提供商 CLI（codex/claude/gemini/antigravity）。若这些 CLI 读取项目目录或外置硬盘，macOS 可能会向 CodexBar 请求该文件夹 / 卷的访问权限（如桌面或外置硬盘）。这由 CLI 的工作目录触发，而非后台磁盘扫描。
- **不会申请的权限**：不需要屏幕录制、辅助功能或自动化权限；不存储密码（选择启用时复用浏览器 Cookie）。

## 文档
- 提供商概览：[docs/providers.md](docs/providers.md)
- 提供商开发指南：[docs/provider.md](docs/provider.md)
- Issue 标签指南：[docs/ISSUE_LABELING.md](docs/ISSUE_LABELING.md)
- UI 与图标说明：[docs/ui.md](docs/ui.md)
- CLI 参考：[docs/cli.md](docs/cli.md)
- 架构说明：[docs/architecture.md](docs/architecture.md)
- 刷新循环：[docs/refresh-loop.md](docs/refresh-loop.md)
- 状态轮询：[docs/status.md](docs/status.md)
- Sparkle 更新：[docs/sparkle.md](docs/sparkle.md)
- 发布清单：[docs/RELEASING.md](docs/RELEASING.md)

## 开发入门
- Clone 仓库后用 Xcode 打开，或直接运行脚本。
- 首次启动后，在「设置 → 提供商」中开启相应提供商。
- 安装 / 登录你依赖的提供商源（CLI、浏览器 Cookie 或 OAuth）。
- 可选：设置 OpenAI Cookie（自动或手动）以获取 Codex 仪表盘附加信息。

## 从源码构建
```bash
swift build -c release          # 发布版；debug 用于开发
./Scripts/package_app.sh        # 原地构建 CodexBar.app
CODEXBAR_SIGNING=adhoc ./Scripts/package_app.sh  # 临时签名（无需 Apple 开发者账号）
open CodexBar.app
```

开发循环：
```bash
./Scripts/compile_and_run.sh
```

## 相关项目
- ✂️ [Trimmy](https://github.com/steipete/Trimmy) — "粘贴一次，运行一次。" 将多行 Shell 片段展平，使其可一键粘贴并运行。
- 🧳 [MCPorter](https://mcporter.dev) — 用于 Model Context Protocol 服务器的 TypeScript 工具包 + CLI。
- 🧿 [oracle](https://askoracle.dev) — 卡住时向 Oracle 求助。以自定义上下文和文件调用 GPT-5 Pro。

## 寻找 Windows 版本？
- [Win-CodexBar](https://github.com/Finesssee/Win-CodexBar)

## 致谢
灵感来源于 [ccusage](https://github.com/ryoppippi/ccusage)（MIT），尤其是费用用量追踪功能。

## 许可证
MIT • Peter Steinberger ([steipete](https://twitter.com/steipete))
