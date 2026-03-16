# TOOLS.md - StarDots Tools

_Local tool configurations for image management._

## StarDots Configuration

### API Settings
```bash
STARDOTS_API_KEY="your-api-key-here"
STARDOTS_API_SECRET="your-api-secret-here"
STARDOTS_SPACE="your-space-name"
STARDOTS_API_URL="https://api.stardots.io"
STARDOTS_DEFAULT_PRIVACY="private"
```

### Installation (Built-in Skill)

**此模板已内置 stardots-backup-skill，无需单独安装！**

Skill 位置：
```
templates/stardots/skills/stardots-backup-skill/
```

安装 Agent 后，skill 会自动部署到：
```bash
~/.agents/skills/stardots-backup-skill/
```

### Manual Installation (Optional)
```bash
# 如果需要手动安装
clawhub install stardots-backup-skill

# 或从 GitHub
git clone https://github.com/keepchen/stardots-backup-skill.git ~/.agents/skills/stardots-backup-skill
```

## Required Skills

| Skill | Purpose | Status |
|-------|---------|--------|
| `stardots-backup-skill` | Image upload & management | ✅ Required |
| `feishu-doc` | Backup documentation | ⚪ Optional |
| `cli-anything` | Command-line operations | ⚪ Optional |

## Local Commands

### Quick Upload
```bash
# Upload single image
stardots upload /path/to/image.png

# Upload with custom name
stardots upload /path/to/image.png --name "custom-name"

# Upload to specific folder
stardots upload /path/to/image.png --folder "project-name"
```

### List Backups
```bash
# List recent uploads
stardots list --recent 10

# List by folder
stardots list --folder "chat-backup"
```

### Get Links
```bash
# Get public link
stardots link <file-id>

# Get temporary link (24h)
stardots link <file-id> --expires 24h
```

## Environment Variables

```bash
# Add to ~/.openclaw/.env
STARDOTS_API_KEY="your-api-key"
STARDOTS_DEFAULT_FOLDER="chat-backup"
STARDOTS_AUTO_BACKUP="true"
```

## Backup Log Location

```
~/.openclaw/workspace/agents/stardots-agent/memory/stardots-backup-log.md
```

## Rate Limits

- **Upload Limit:** [X] images per minute
- **Storage Limit:** [X] GB total
- **Bandwidth Limit:** [X] GB per month

## Troubleshooting

### Common Issues

1. **Upload fails**
   - Check API key validity
   - Verify network connection
   - Check file size limits

2. **Link not accessible**
   - Verify privacy settings
   - Check if link expired
   - Confirm folder permissions

3. **Duplicate detection**
   - Check existing backups
   - Use `--force` to override

---

_Keep your StarDots credentials secure. Never commit API keys to version control._
