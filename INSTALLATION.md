# Installation Guide

## Installing Skills

To use the skills from this repository in Claude Code:

### Option 1: Manual Installation (Recommended)

1. **Locate your Claude skills directory**:
   ```bash
   # Default location is typically:
   ~/.claude/skills/
   ```

2. **Copy skill files**:
   ```bash
   cp skills/*.md ~/.claude/skills/
   ```

3. **Verify installation**:
   - Open Claude Code
   - Type `/` to see available skills
   - Your new skills should appear in the list

### Option 2: Symlink (For Development)

If you're actively developing skills, create a symlink:

```bash
# Backup existing skills directory first
mv ~/.claude/skills ~/.claude/skills.backup

# Create symlink to this repo's skills directory
ln -s /path/to/tuckers_claude_skills/skills ~/.claude/skills
```

## Testing Skills

After installation, test the tech-debt skill:

1. Navigate to a project directory
2. Run: `/tech-debt` or type "analyze tech debt"
3. Claude will perform a comprehensive analysis

## Troubleshooting

**Skill not appearing:**
- Ensure the skill file has the correct YAML frontmatter
- Check that the file is in the skills directory
- Restart Claude Code

**Skill not triggering:**
- Try using the exact trigger phrases listed in the skill
- Use the `/` command to invoke directly

## Updating Skills

To update skills from this repository:

```bash
cd /path/to/tuckers_claude_skills
git pull
cp skills/*.md ~/.claude/skills/
```

## Uninstalling

To remove a skill:

```bash
rm ~/.claude/skills/tech-debt.md
```
