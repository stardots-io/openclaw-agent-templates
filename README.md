# OpenClaw Agent Templates 🦄

> OpenClaw Agent 模板脚手架，快速创建你的专属 AI 助手。

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![OpenClaw](https://img.shields.io/badge/OpenClaw-compatible-blue)](https://github.com/openclaw/openclaw)

## 🚀 快速开始

### 方式 1: 使用安装脚本（推荐）

```bash
# 安装默认 Agent
curl -fsSL https://raw.githubusercontent.com/stardots-io/openclaw-agent-templates/main/scripts/install.sh | bash -s my-assistant

# 安装StarDots助手
curl -fsSL https://raw.githubusercontent.com/stardots-io/openclaw-agent-templates/main/scripts/install.sh | bash -s my-stardots stardots
```

### 方式 2: Git Clone

```bash
# 克隆模板仓库
git clone https://github.com/stardots-io/openclaw-agent-templates.git

# 复制StarDots模板到工作区
cp -r openclaw-agent-templates/templates/stardots \
  ~/.openclaw/workspace/agents/my-assistant

# 启动 OpenClaw
openclaw gateway start
```

### 方式 3: 下载解压

1. 下载 [ZIP](https://github.com/stardots-io/openclaw-agent-templates/archive/main.zip)
2. 解压
3. 复制 `templates/stardots` 到 `~/.openclaw/workspace/agents/你的 agent 名`
4. 启动 OpenClaw

## 📦 可用模板

| 模板 | 用途 | 适用场景 | Emoji | 内置 Skills |
|------|------|----------|-------|-------------|
| `stardots` | StarDots助手 | 图像备份和托管 | 📸 | - |

## 🛠️ 使用脚本

### 安装 Agent

```bash
cd openclaw-agent-templates
./scripts/install.sh <agent-name> [template-name]

# 示例
./scripts/install.sh my-assistant stardots
```

### 激活 Agent

```bash
./scripts/activate.sh
```

### 列出可用模板

```bash
ls templates/
```

## 📁 目录结构

```
openclaw-agent-templates/
├── README.md                 # 本文件
├── LICENSE                   # MIT 许可证
├── templates/                # 模板集合
│   └── stardots/             # stardots模板
│       ├── SOUL.md           # 核心行为准则
│       ├── USER.md           # 用户信息
│       ├── IDENTITY.md       # Agent 身份
│       ├── AGENTS.md         # 工作区规则
│       ├── TOOLS.md          # 本地工具配置
│       ├── MEMORY.md         # 长期记忆
│       ├── HEARTBEAT.md      # 心跳配置
│       └── BOOTSTRAP.md      # 首次启动引导
│
└── scripts/                  # 辅助脚本
    ├── install.sh            # 安装脚本
    └── activate.sh           # 激活脚本
```

## 🎯 核心文件说明

| 文件 | 作用 | 必填 |
|------|------|------|
| `SOUL.md` | 核心行为准则、价值观 | ✅ |
| `IDENTITY.md` | Agent 身份定义（名字、emoji 等） | ✅ |
| `USER.md` | 用户信息（名字、时区、偏好） | ✅ |
| `AGENTS.md` | 工作区规则（可继承默认） | ❌ |
| `TOOLS.md` | 本地工具配置（SSH、API 等） | ❌ |
| `MEMORY.md` | 长期记忆（重要事件、决策） | ❌ |
| `HEARTBEAT.md` | 心跳任务配置 | ❌ |
| `BOOTSTRAP.md` | 首次启动引导（用后删除） | ❌ |

## 🔧 自定义模板

### 创建自己的模板

```bash
# 1. 复制默认模板
cp -r templates/default templates/my-custom-agent

# 2. 编辑核心文件
vim templates/my-custom-agent/SOUL.md
vim templates/my-custom-agent/IDENTITY.md

# 3. 测试
./scripts/install.sh test-agent my-custom-agent

# 4. 分享
git add templates/my-custom-agent
git commit -m "Add my-custom-agent template"
git push
```

### 修改现有模板

直接编辑 `templates/<template-name>/` 下的文件，然后提交 PR。

## 📖 使用示例

### 示例 1: 创建个人助手

```bash
# 安装
./scripts/install.sh keepchen-assistant default

# 编辑身份
vim ~/.openclaw/workspace/agents/keepchen-assistant/IDENTITY.md

# 编辑用户信息
vim ~/.openclaw/workspace/agents/keepchen-assistant/USER.md

# 启动 OpenClaw
openclaw gateway start
```

### 示例 2: 创建代码审查助手

```bash
# 安装代码助手模板
./scripts/install.sh code-reviewer coder

# 自定义技能
vim ~/.openclaw/workspace/agents/code-reviewer/SOUL.md

# 添加工具配置
vim ~/.openclaw/workspace/agents/code-reviewer/TOOLS.md
```

## 🤝 贡献

欢迎提交 PR 分享你的模板！

### 提交新模板

1. Fork 本仓库
2. 创建新模板：`cp -r templates/default templates/your-template`
3. 编辑模板文件
4. 提交 PR，说明模板用途

### 改进现有模板

1. Fork 本仓库
2. 修改模板文件
3. 提交 PR，说明改进内容

### 报告问题

在 [Issues](https://github.com/stardots-io/openclaw-agent-templates/issues) 中报告。

## 📝 FAQ

### Q: 我可以同时有多个 Agent 吗？

A: 可以！每个 Agent 是独立的目录，切换时修改配置或重启 OpenClaw。

### Q: 如何备份我的 Agent 配置？

A: 备份 `~/.openclaw/workspace/agents/` 目录即可。

### Q: 如何分享我的 Agent 配置？

A: 
1. 导出配置：`tar czvf my-agent.tar.gz ~/.openclaw/workspace/agents/my-agent/`
2. 或提交到本仓库作为新模板

### Q: 修改配置后需要重启吗？

A: 大部分配置修改后需要重启 OpenClaw Gateway。

## 🔗 相关链接

- [OpenClaw 官方文档](https://docs.openclaw.ai)
- [OpenClaw GitHub](https://github.com/openclaw/openclaw)
- [ClawHub - Skill 市场](https://clawhub.com)
- [OpenClaw Discord 社区](https://discord.gg/clawd)

## 📄 License

MIT License - 详见 [LICENSE](LICENSE) 文件

---

Made with ❤️ for the OpenClaw Community
