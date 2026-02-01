# Tucker's Claude Skills

A collection of custom Claude Code skills for enhanced development workflows.

## Overview

This repository contains custom skills that extend Claude Code's capabilities. Skills are specialized tools that can be invoked using the `/skill-name` syntax in Claude Code.

## Available Skills

### tech-debt

Performs comprehensive technical debt analysis on your codebase.

**Triggers**: `analyze tech debt`, `find duplication`, `reduce tech debt`, `code quality analysis`

**What it analyzes**:
- Code duplication and similar code blocks
- Unused/dead code (functions, imports, variables)
- Overly complex functions and deep nesting
- Code smells (magic numbers, hardcoded values, etc.)
- Architectural issues (tight coupling, circular dependencies)

**Output**: Generates a prioritized markdown report with:
- Specific file locations (file.ext:line_number)
- Concrete refactoring recommendations
- Effort estimates (Quick Win / Medium / Large)
- Impact assessments (High / Medium / Low)
- Actionable improvement plan

**Usage**:
```
/tech-debt
```
or simply say "analyze tech debt" in any conversation

## Installation

**Quick Install:**
```bash
./install.sh
```

**Uninstall:**
```bash
./uninstall.sh
```

See [INSTALLATION.md](INSTALLATION.md) for detailed setup instructions and manual installation options.

## Usage

To use a skill from this repository:

1. Ensure skills are installed in `~/.claude/skills/`
2. Invoke a skill using `/skill-name` syntax (e.g., `/tech-debt`)
3. Or use natural language triggers (e.g., "analyze tech debt")
4. Skills can also be called programmatically via the Skill tool

## Development

Skills are defined using Claude's skill format, which includes:
- Skill metadata (name, description, triggers)
- Prompts and instructions
- Configuration options

## Contributing

Feel free to add new skills or improve existing ones. Each skill should:
- Have a clear, specific purpose
- Include comprehensive documentation
- Follow consistent naming conventions
- Provide useful error handling

## License

MIT
