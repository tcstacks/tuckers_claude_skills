---
name: frontend-to-browser-prd
description: "Analyze a frontend codebase, extract user stories from all features, and create a prd.json with Chrome MCP browser-based acceptance criteria for manual verification. Triggers on: frontend stories, browser prd, chrome mcp stories, extract frontend features, analyze frontend for stories."
---

# Frontend to Browser-Verified PRD

Analyzes a frontend codebase to discover all features, generates comprehensive user stories, and creates a prd.json with Chrome MCP browser-based acceptance criteria for manual verification.

---

## The Job

1. **Explore the frontend codebase** to discover all pages, components, and features
2. **Generate user stories** for each discoverable feature
3. **Create prd.json** with Chrome MCP acceptance criteria (navigate, click, fill, take_snapshot)
4. Output ready for `ralph-tui run --prd <path>` with browser verification

---

## Step 1: Explore the Frontend

Use the Task tool with `subagent_type=Explore` to analyze:

```
Analyze this frontend codebase thoroughly. For each discovery, note:

1. **Pages/Routes**: All routable pages and their paths
2. **Components**: Reusable components and their purposes
3. **Features**: Interactive features (forms, modals, dropdowns, etc.)
4. **State Management**: Contexts, stores, and their data flows
5. **API Integration**: Endpoints called and their purposes
6. **Authentication**: Auth flows, protected routes, user states
7. **Real-time Features**: WebSocket connections, live updates
```

### Key directories to analyze:

- `src/pages/` or `src/app/` - Route pages
- `src/components/` - UI components
- `src/contexts/` or `src/store/` - State management
- `src/hooks/` - Custom hooks
- `src/lib/` or `src/utils/` - Utilities and API clients

---

## Step 2: Categorize Features

Group discovered features into categories:

| Category         | Examples                                     |
| ---------------- | -------------------------------------------- |
| Authentication   | Login, register, logout, session management  |
| Navigation       | Routing, menus, breadcrumbs                  |
| Forms            | Input validation, submission, error handling |
| Data Display     | Lists, tables, cards, details views          |
| Modals/Dialogs   | Confirmations, alerts, overlays              |
| Real-time        | WebSocket connections, live updates          |
| State Management | Context providers, global state              |
| Error Handling   | Error boundaries, fallbacks, toasts          |

---

## Step 3: Generate User Stories

For each feature, create a user story in this format:

```
**[CATEGORY-##] [Title]**
As a [user type], I want [action] so that [benefit]

**Acceptance Criteria (Browser Verification):**
1. Navigate to [route]
2. [Action using Chrome MCP tool]
3. Verify [expected result]
4. Take snapshot to confirm
```

### Chrome MCP Tools for Acceptance Criteria

Use these specific tool references in acceptance criteria:

| Action        | Chrome MCP Tool | Example Criterion                               |
| ------------- | --------------- | ----------------------------------------------- |
| Go to page    | `navigate_page` | "Navigate to /login page"                       |
| Click element | `click`         | "Click the 'Submit' button"                     |
| Type text     | `fill`          | "Fill username field with 'testuser'"           |
| View state    | `take_snapshot` | "Take snapshot to verify logged-in state"       |
| Check element | `take_snapshot` | "Take snapshot - confirm error message visible" |
| Keyboard      | `press_key`     | "Press Enter to submit form"                    |
| Wait          | `wait_for`      | "Wait for 'Success' text to appear"             |

---

## Step 4: Create prd.json

Output format with browser-based acceptance criteria:

```json
{
  "name": "[project-name]-frontend-verification",
  "description": "Frontend user stories verified via Chrome MCP browser automation",
  "branchName": "ralph/[feature]-frontend-verify",
  "userStories": [
    {
      "id": "AUTH-01",
      "title": "User login with credentials",
      "description": "As a user, I can log in with my username and password",
      "acceptanceCriteria": [
        "Navigate to the app at localhost:5173",
        "Click 'Login' button to open auth modal",
        "Fill username field with test credentials",
        "Fill password field with test credentials",
        "Click 'Login' submit button",
        "Wait for modal to close",
        "Take snapshot - verify username appears in header",
        "Take snapshot - verify 'Logout' option is available"
      ],
      "priority": 1,
      "passes": false,
      "notes": "",
      "dependsOn": [],
      "metadata": {
        "category": "Authentication",
        "verificationType": "browser"
      }
    }
  ],
  "metadata": {
    "verificationType": "Chrome MCP Browser Automation",
    "baseUrl": "http://localhost:5173",
    "instructions": "Each story must be verified by navigating in browser, performing actions, and taking snapshots to confirm the user flow works end-to-end"
  }
}
```

---

## Acceptance Criteria Rules

### DO: Write actionable, verifiable steps

```
"Navigate to /play page"
"Click the 'Start Game' button"
"Fill the answer input with 'HELLO'"
"Press Enter to submit"
"Take snapshot - verify 'Correct!' message appears"
"Take snapshot - verify score increased by 1"
```

### DON'T: Write vague or test-based criteria

```
"User can log in successfully" (vague)
"npm run test passes" (not browser-based)
"Authentication works correctly" (not actionable)
"Good user experience" (subjective)
```

### Include visual verification

Every user story MUST end with at least one `take_snapshot` step that confirms the expected outcome is visible in the browser.

---

## Story Categories and ID Prefixes

Use consistent ID prefixes for categories:

| Prefix   | Category                                 |
| -------- | ---------------------------------------- |
| `AUTH-`  | Authentication (login, register, logout) |
| `NAV-`   | Navigation (routing, menus)              |
| `GAME-`  | Game/Core features                       |
| `UI-`    | UI components (modals, toasts)           |
| `STATE-` | State management                         |
| `API-`   | API integration                          |
| `WS-`    | WebSocket/Real-time                      |
| `ERR-`   | Error handling                           |
| `PERF-`  | Performance features                     |

---

## Dependencies

Set `dependsOn` based on feature relationships:

1. **Authentication first** - Most features require auth
2. **Core features** - Before advanced features
3. **UI components** - Before features that use them
4. **State setup** - Before features that depend on state

Example dependency chain:

```
AUTH-01 (login) → GAME-01 (start game) → GAME-02 (submit answer) → GAME-03 (view results)
```

---

## Output Location

Default: `./tasks/frontend-tests-prd.json`

This keeps frontend verification tasks separate from backend PRDs.

---

## Complete Example

**Input:** React frontend with auth, gameplay, and social features

**Output prd.json:**

```json
{
  "name": "crossplay-frontend-verification",
  "description": "All frontend features verified via Chrome MCP browser automation",
  "branchName": "ralph/frontend-browser-verify",
  "userStories": [
    {
      "id": "AUTH-01",
      "title": "User registration with credentials",
      "description": "As a new user, I can register with username, email, and password",
      "acceptanceCriteria": [
        "Navigate to the app at localhost:5173",
        "Click 'Login' to open auth modal",
        "Click 'Register' tab",
        "Fill username field with 'newuser123'",
        "Fill email field with 'newuser@test.com'",
        "Fill password field with 'TestPass123!'",
        "Click 'Register' button",
        "Wait for modal to close",
        "Take snapshot - verify username 'newuser123' appears in header"
      ],
      "priority": 1,
      "passes": false,
      "notes": "",
      "dependsOn": [],
      "metadata": {
        "category": "Authentication",
        "verificationType": "browser"
      }
    },
    {
      "id": "AUTH-02",
      "title": "User login with credentials",
      "description": "As a returning user, I can log in with my credentials",
      "acceptanceCriteria": [
        "Navigate to the app at localhost:5173",
        "Click 'Login' to open auth modal",
        "Fill username field with existing credentials",
        "Fill password field with existing credentials",
        "Click 'Login' button",
        "Wait for modal to close",
        "Take snapshot - verify user is authenticated"
      ],
      "priority": 1,
      "passes": false,
      "notes": "",
      "dependsOn": [],
      "metadata": {
        "category": "Authentication",
        "verificationType": "browser"
      }
    },
    {
      "id": "GAME-01",
      "title": "Start daily puzzle",
      "description": "As an authenticated user, I can start playing the daily puzzle",
      "acceptanceCriteria": [
        "Complete AUTH-02 to log in",
        "Navigate to /play page",
        "Take snapshot - verify puzzle grid is displayed",
        "Take snapshot - verify clue text is visible",
        "Take snapshot - verify input field is ready for answers"
      ],
      "priority": 2,
      "passes": false,
      "notes": "",
      "dependsOn": ["AUTH-02"],
      "metadata": {
        "category": "Gameplay",
        "verificationType": "browser"
      }
    },
    {
      "id": "GAME-02",
      "title": "Submit answer to puzzle",
      "description": "As a player, I can submit answers and see feedback",
      "acceptanceCriteria": [
        "Complete GAME-01 to view puzzle",
        "Fill answer input with a word",
        "Press Enter or click Submit",
        "Take snapshot - verify answer appears in guess history",
        "Take snapshot - verify feedback colors shown (green/yellow/gray)"
      ],
      "priority": 3,
      "passes": false,
      "notes": "",
      "dependsOn": ["GAME-01"],
      "metadata": {
        "category": "Gameplay",
        "verificationType": "browser"
      }
    }
  ],
  "metadata": {
    "verificationType": "Chrome MCP Browser Automation",
    "baseUrl": "http://localhost:5173",
    "instructions": "Each story must be verified by navigating in browser, performing actions, and taking snapshots to confirm the user flow works end-to-end"
  }
}
```

---

## Execution Workflow

After creating the prd.json:

1. **Start the dev server:**

   ```bash
   npm run dev
   ```

2. **Run ralph-tui with browser verification:**

   ```bash
   ralph-tui run --prd ./tasks/frontend-tests-prd.json
   ```

3. **For each story, the agent will:**
   - Read the acceptance criteria
   - Use Chrome MCP tools to perform each step
   - Take snapshots to verify outcomes
   - Mark story as passed if all criteria verified

---

## Checklist Before Saving

- [ ] Explored all pages, components, and features
- [ ] Categorized features with appropriate ID prefixes
- [ ] Each story has actionable Chrome MCP acceptance criteria
- [ ] Every story ends with `take_snapshot` verification
- [ ] Dependencies correctly chain related features
- [ ] No vague or test-based criteria
- [ ] Base URL specified in metadata
- [ ] Stories are sized for single-context completion

---

## Installation

To install this skill globally, copy to your Claude skills directory:

```bash
mkdir -p ~/.claude/skills/frontend-to-browser-prd
cp .context/frontend-to-browser-prd-SKILL.md ~/.claude/skills/frontend-to-browser-prd/SKILL.md
```

Then it will be available as `/frontend-to-browser-prd` in any project.
