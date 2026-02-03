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

---

### fullstack-e2e-stories

Analyzes both frontend and backend in a git repo, extracts integrated user stories, and generates Playwright E2E tests.

**Triggers**: `fullstack stories`, `e2e user stories`, `analyze full stack`, `playwright stories`, `extract all stories`, `full feature test`

**What it does**:
1. **Backend Analysis** - API routes, database models, business logic, auth flows
2. **Frontend Analysis** - Pages, components, state management, UI interactions
3. **Integration Mapping** - How frontend calls backend, data flow, API contracts
4. **User Story Extraction** - Unified stories covering the full stack
5. **Playwright E2E Testing** - Automated browser tests validating complete user flows

**Output**:
- `tasks/fullstack-e2e-prd.json` - ralph-tui compatible PRD for automated execution
- `tests/e2e/*.spec.ts` - Playwright test files organized by category
- `STORIES.md` - Human-readable story document

**Run with ralph-tui**:
```bash
ralph-tui run --prd ./tasks/fullstack-e2e-prd.json --headless
```

**Story Categories**:
- `AUTH-` Authentication (login, register, sessions)
- `USER-` User management (profile, settings)
- `DATA-` Data operations (CRUD, search, filter)
- `FORM-` Form handling (validation, submission)
- `NAV-` Navigation (routing, menus)
- `RT-` Real-time (WebSockets, live updates)

**Usage**:
```
/fullstack-e2e-stories
```
or say "analyze full stack" or "playwright stories" in any conversation

---

### create_frontend_user_stories

Analyzes frontend codebase and creates user stories with Chrome MCP browser-based acceptance criteria.

**Triggers**: `frontend stories`, `browser prd`, `chrome mcp stories`, `extract frontend features`

**What it does**:
- Explores frontend pages, components, and features
- Generates user stories with browser verification criteria
- Creates `prd.json` for ralph-tui execution

**Usage**:
```
/create_frontend_user_stories
```

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
