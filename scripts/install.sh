#!/bin/bash
# OpenClaw Agent 模板安装脚本
# 用法：./install.sh <agent-name> [template-name]

set -e

# 配置
REPO_URL="https://github.com/stardots-io/openclaw-agent-templates.git"
WORKSPACE_DIR="$HOME/.openclaw/workspace/agents"
TEMPLATE_NAME="${2:-default}"
AGENT_NAME="$1"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印函数
info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
success() { echo -e "${GREEN}✅ $1${NC}"; }
warn() { echo -e "${YELLOW}⚠️  $1${NC}"; }
error() { echo -e "${RED}❌ $1${NC}"; }

# 检查参数
if [ -z "$AGENT_NAME" ]; then
    echo "用法：$0 <agent-name> [template-name]"
    echo ""
    echo "示例:"
    echo "  $0 my-assistant default     # 创建默认助手"
    echo "  $0 my-coder coder           # 创建代码助手"
    echo "  $0 my-writer writer         # 创建写作助手"
    exit 1
fi

# 检查 OpenClaw 是否安装
check_openclaw() {
    if ! command -v openclaw &> /dev/null; then
        error "OpenClaw 未安装"
        echo ""
        echo "请先安装 OpenClaw:"
        echo "  npm install -g openclaw"
        echo ""
        echo "或者访问：https://github.com/openclaw/openclaw"
        exit 1
    fi
    success "OpenClaw 已安装：$(openclaw --version 2>/dev/null || echo 'unknown')"
}

# 克隆或更新模板仓库
clone_templates() {
    TEMPLATE_DIR="/tmp/openclaw-templates-$$"
    
    if [ -d "$TEMPLATE_DIR" ]; then
        info "更新模板仓库..."
        (cd "$TEMPLATE_DIR" && git pull --quiet)
    else
        info "克隆模板仓库..."
        git clone --depth 1 --quiet "$REPO_URL" "$TEMPLATE_DIR"
    fi
}

# 检查模板是否存在
check_template() {
    if [ ! -d "$TEMPLATE_DIR/templates/$TEMPLATE_NAME" ]; then
        error "模板 '$TEMPLATE_NAME' 不存在"
        echo ""
        echo "可用模板："
        ls -1 "$TEMPLATE_DIR/templates/" | while read template; do
            echo "  - $template"
        done
        rm -rf "$TEMPLATE_DIR"
        exit 1
    fi
    success "找到模板：$TEMPLATE_NAME"
}

# 创建工作区
create_workspace() {
    info "创建工作区目录..."
    mkdir -p "$WORKSPACE_DIR"
    
    if [ -d "$WORKSPACE_DIR/$AGENT_NAME" ]; then
        warn "Agent '$AGENT_NAME' 已存在"
        echo ""
        read -p "是否覆盖？(y/N): " confirm
        if [ "$confirm" != "y" ]; then
            info "已取消"
            rm -rf "$TEMPLATE_DIR"
            exit 0
        fi
        rm -rf "$WORKSPACE_DIR/$AGENT_NAME"
    fi
}

# 复制模板
copy_template() {
    info "复制模板 '$TEMPLATE_NAME'..."
    cp -r "$TEMPLATE_DIR/templates/$TEMPLATE_NAME" "$WORKSPACE_DIR/$AGENT_NAME"
    
    # 创建今日记忆文件
    TODAY=$(date +%Y-%m-%d)
    mkdir -p "$WORKSPACE_DIR/$AGENT_NAME/memory"
    
    if [ -f "$TEMPLATE_DIR/templates/$TEMPLATE_NAME/memory/YYYY-MM-DD.md.template" ]; then
        cp "$TEMPLATE_DIR/templates/$TEMPLATE_NAME/memory/YYYY-MM-DD.md.template" \
           "$WORKSPACE_DIR/$AGENT_NAME/memory/$TODAY.md"
    else
        cat > "$WORKSPACE_DIR/$AGENT_NAME/memory/$TODAY.md" << EOF
# $TODAY

## What Happened Today

- Agent initialized

## Notes

_(待填写)_

---

_Raw notes from today._
EOF
    fi
    
    # 如果模板包含内置 skills，自动部署
    if [ -d "$TEMPLATE_DIR/templates/$TEMPLATE_NAME/skills" ]; then
        info "部署内置 skills..."
        mkdir -p "$HOME/.agents/skills"
        
        for skill_dir in "$TEMPLATE_DIR/templates/$TEMPLATE_NAME/skills"/*; do
            if [ -d "$skill_dir" ]; then
                skill_name=$(basename "$skill_dir")
                info "  安装 skill: $skill_name"
                cp -r "$skill_dir" "$HOME/.agents/skills/"
            fi
        done
        
        success "内置 skills 已部署到 ~/.agents/skills/"
    fi
    
    success "模板已复制到：$WORKSPACE_DIR/$AGENT_NAME"
}

# 清理
cleanup() {
    rm -rf "$TEMPLATE_DIR"
}

# 显示下一步
show_next_steps() {
    echo ""
    echo "=========================================="
    success "Agent '$AGENT_NAME' 创建完成！"
    echo "=========================================="
    echo ""
    info "工作区位置："
    echo "  $WORKSPACE_DIR/$AGENT_NAME"
    echo ""
    info "已创建的文件："
    ls -1 "$WORKSPACE_DIR/$AGENT_NAME/" | head -10
    echo ""
    info "下一步："
    echo ""
    echo "  1. 编辑身份配置"
    echo "     vim $WORKSPACE_DIR/$AGENT_NAME/IDENTITY.md"
    echo ""
    echo "  2. 编辑用户信息"
    echo "     vim $WORKSPACE_DIR/$AGENT_NAME/USER.md"
    echo ""
    echo "  3. 启动 OpenClaw"
    echo "     openclaw gateway start"
    echo ""
    echo "  或者，直接开始对话，Agent 会通过 BOOTSTRAP.md 引导你完成配置！"
    echo ""
    info "查看可用命令："
    echo "  openclaw --help"
    echo ""
}

# 主函数
main() {
    echo ""
    echo "=========================================="
    echo "  OpenClaw Agent 安装工具"
    echo "=========================================="
    echo ""
    
    # 检查 OpenClaw
    check_openclaw
    echo ""
    
    # 克隆模板
    clone_templates
    
    # 检查模板
    check_template
    
    # 创建工作区
    create_workspace
    
    # 复制模板
    copy_template
    
    # 清理
    cleanup
    
    # 显示下一步
    show_next_steps
}

# 运行
main "$@"
