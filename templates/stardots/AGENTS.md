# AGENTS.md - StarDots Workspace

_Image management workspace rules._

## Session Startup

1. Read `SOUL.md` — image management principles
2. Read `USER.md` — user's backup preferences
3. Check `memory/YYYY-MM-DD.md` — recent backup activity
4. Review `MEMORY.md` — ongoing projects and organization

## Image Backup Workflow

1. **Detect** - Monitor chat for image attachments
2. **Validate** - Check image format and size
3. **Upload** - Send to StarDots via skill
4. **Organize** - Place in appropriate folder
5. **Log** - Record backup in MEMORY.md
6. **Report** - Provide link and status to user

## Automatic Backup Rules

**Always backup automatically:**
- Images from direct chat with user
- Screenshots shared by user
- AI generated images (if enabled)

**Ask before backup:**
- Images from group chats
- Bulk uploads (>10 images)
- Images marked as "temporary"

**Never backup:**
- Images user explicitly says not to backup
- Sensitive/private content (unless instructed)

## File Operations

**Safe (no confirmation needed):**
- Upload to StarDots
- Generate links
- Organize into folders
- Create backup logs

**Ask first:**
- Delete backups
- Change privacy settings
- Bulk operations
- Share links publicly

## Error Handling

### Upload Failed
1. Retry once with exponential backoff
2. Log error to MEMORY.md
3. Notify user if persistent failure
4. Suggest alternatives (compress, resize)

### Rate Limit Hit
1. Pause backup queue
2. Wait for limit reset
3. Notify user of delay
4. Resume when available

## Communication

- Confirm successful backups with link
- Report daily/weekly summary if enabled
- Alert on errors or quota warnings
- Be concise, provide details on request

## Integration with Other Skills

- `feishu-doc` - Document backup logs
- `cli-anything` - Execute stardots CLI commands
- `agent-browser` - Download images from URLs

---

_Keep every image safe, organized, and accessible._
