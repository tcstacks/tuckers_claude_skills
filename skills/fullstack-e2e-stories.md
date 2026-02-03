---
name: fullstack-e2e-stories
description: "Analyze a git repo's frontend and backend, extract user stories from both, integrate them, and test full feature functionality via Playwright. Triggers on: fullstack stories, e2e user stories, analyze full stack, playwright stories, extract all stories, full feature test."
triggers:
  - fullstack stories
  - e2e user stories
  - analyze full stack
  - playwright stories
  - extract all stories
  - full feature test
  - analyze frontend and backend
  - integrated user stories
---

# Fullstack E2E User Stories with Playwright Testing

Analyzes a complete git repository (frontend + backend), extracts comprehensive user stories from both sides, integrates them into end-to-end flows, and tests functionality via Playwright browser automation.

---

## Overview

This skill performs a complete analysis of your codebase:

1. **Backend Analysis** - API routes, database models, business logic, auth flows
2. **Frontend Analysis** - Pages, components, state management, UI interactions
3. **Integration Mapping** - How frontend calls backend, data flow, contract validation
4. **User Story Extraction** - Unified stories covering the full stack
5. **Playwright E2E Testing** - Automated browser tests validating complete user flows

---

## Phase 1: Backend Analysis

Use the Task tool with `subagent_type=Explore` to analyze backend:

```
Analyze the backend codebase thoroughly. Document:

1. **API Routes/Endpoints**
   - All HTTP endpoints (GET, POST, PUT, DELETE, PATCH)
   - Route paths and their handlers
   - Request/response schemas
   - Authentication requirements per route

2. **Database Models/Schema**
   - All models/entities and their fields
   - Relationships between models
   - Migrations and schema changes

3. **Business Logic**
   - Services and their responsibilities
   - Data transformations
   - Validation rules

4. **Authentication/Authorization**
   - Auth mechanisms (JWT, sessions, OAuth)
   - Role-based access control
   - Protected routes

5. **External Integrations**
   - Third-party APIs
   - Message queues
   - Cache layers
```

### Backend Directories to Analyze

| Framework | Key Directories |
|-----------|-----------------|
| Express/Node | `src/routes/`, `src/controllers/`, `src/models/`, `src/middleware/` |
| Django | `*/views.py`, `*/models.py`, `*/urls.py`, `*/serializers.py` |
| FastAPI | `app/routers/`, `app/models/`, `app/schemas/`, `app/dependencies/` |
| Rails | `app/controllers/`, `app/models/`, `config/routes.rb` |
| Go | `internal/handlers/`, `internal/models/`, `cmd/` |
| Rust/Axum | `src/routes/`, `src/handlers/`, `src/models/` |

---

## Phase 2: Frontend Analysis

Use the Task tool with `subagent_type=Explore` to analyze frontend:

```
Analyze the frontend codebase thoroughly. Document:

1. **Pages/Routes**
   - All routable pages and URL paths
   - Route parameters and query strings
   - Navigation flows

2. **Components**
   - Reusable UI components
   - Props and state they accept
   - Events they emit

3. **State Management**
   - Global state (Redux, Context, Zustand, etc.)
   - Local component state
   - Server state (React Query, SWR, etc.)

4. **API Integration**
   - API client configuration
   - Endpoints called from frontend
   - Request/response handling

5. **Forms and Validation**
   - Form components and libraries
   - Client-side validation rules
   - Error display patterns

6. **Authentication UI**
   - Login/register forms
   - Protected route handling
   - Auth state management
```

### Frontend Directories to Analyze

| Framework | Key Directories |
|-----------|-----------------|
| React | `src/pages/`, `src/components/`, `src/hooks/`, `src/contexts/` |
| Next.js | `app/`, `pages/`, `components/`, `lib/` |
| Vue | `src/views/`, `src/components/`, `src/stores/`, `src/composables/` |
| Svelte | `src/routes/`, `src/lib/`, `src/stores/` |
| Angular | `src/app/`, `src/components/`, `src/services/` |

---

## Phase 3: Integration Mapping

After analyzing both sides, map the connections:

```markdown
## API Contract Mapping

| Frontend Action | API Endpoint | Backend Handler | Data Flow |
|-----------------|--------------|-----------------|-----------|
| Login form submit | POST /api/auth/login | AuthController.login | Credentials → JWT |
| Fetch user list | GET /api/users | UserController.list | Query → Paginated Users |
| Create item | POST /api/items | ItemController.create | FormData → Created Item |
```

### Identify Integration Points

1. **Direct API Calls** - Frontend fetch/axios → Backend endpoints
2. **WebSocket Connections** - Real-time data flows
3. **Form Submissions** - Data validation on both sides
4. **File Uploads** - Multipart handling
5. **Authentication Flow** - Token lifecycle management

---

## Phase 4: User Story Extraction

Generate integrated user stories covering the full stack:

### Story Format

```
**[CATEGORY-##] [Title]**
As a [user type], I want [action] so that [benefit]

**Backend Requirements:**
- API endpoint(s) involved
- Database operations
- Validation rules
- Auth requirements

**Frontend Requirements:**
- UI components involved
- State changes
- Error handling
- Loading states

**Acceptance Criteria (Playwright E2E):**
1. [Browser action with expected API call]
2. [Verification of UI and data state]
3. [Screenshot or assertion]
```

### Story Categories and Prefixes

| Prefix | Category | Covers |
|--------|----------|--------|
| `AUTH-` | Authentication | Login, register, logout, password reset, sessions |
| `USER-` | User Management | Profile, settings, preferences, roles |
| `DATA-` | Data Operations | CRUD operations, lists, search, filter |
| `FORM-` | Form Handling | Validation, submission, error display |
| `NAV-`  | Navigation | Routing, menus, breadcrumbs, deep links |
| `RT-`   | Real-time | WebSockets, live updates, notifications |
| `FILE-` | File Handling | Upload, download, preview |
| `INT-`  | Integration | Third-party services, external APIs |
| `ERR-`  | Error Handling | Error pages, fallbacks, recovery |
| `PERF-` | Performance | Loading states, caching, optimization |

---

## Phase 5: Playwright E2E Test Generation

### Test File Structure

```typescript
// tests/e2e/[category].spec.ts
import { test, expect } from '@playwright/test';

test.describe('[CATEGORY] - [Feature Group]', () => {

  test.beforeEach(async ({ page }) => {
    // Setup: navigate to base URL, seed data if needed
  });

  test('[STORY-ID] - [Story Title]', async ({ page }) => {
    // 1. Arrange: Setup preconditions

    // 2. Act: Perform user actions

    // 3. Assert: Verify outcomes (UI + API)
  });
});
```

### Playwright Actions Reference

| User Action | Playwright Code | Use For |
|-------------|-----------------|---------|
| Navigate | `await page.goto('/path')` | Opening pages |
| Click | `await page.click('selector')` | Buttons, links, elements |
| Fill form | `await page.fill('input[name="x"]', 'value')` | Text inputs |
| Select | `await page.selectOption('select', 'value')` | Dropdowns |
| Check | `await page.check('input[type="checkbox"]')` | Checkboxes |
| Wait for | `await page.waitForSelector('.element')` | Dynamic content |
| Screenshot | `await page.screenshot({ path: 'name.png' })` | Visual verification |
| Assert text | `await expect(page.locator('.msg')).toHaveText('x')` | Content verification |
| Assert visible | `await expect(page.locator('.el')).toBeVisible()` | Element presence |
| Assert URL | `await expect(page).toHaveURL('/expected')` | Navigation verification |

### API Interception for Full-Stack Verification

```typescript
test('validates API contract during user flow', async ({ page }) => {
  // Intercept API calls to verify backend integration
  let apiResponse;
  await page.route('**/api/endpoint', route => {
    route.continue();
  });

  page.on('response', response => {
    if (response.url().includes('/api/endpoint')) {
      apiResponse = response;
    }
  });

  // Perform user action
  await page.click('button[type="submit"]');

  // Verify both UI and API
  await expect(page.locator('.success')).toBeVisible();
  expect(apiResponse.status()).toBe(200);
});
```

---

## Output Format: prd.json (ralph-tui compatible)

The final output MUST be a `prd.json` file compatible with ralph-tui for automated execution.

```json
{
  "name": "[project-name]-fullstack-e2e",
  "description": "Integrated user stories covering frontend, backend, and E2E tests via Playwright",
  "branchName": "ralph/fullstack-e2e-verify",
  "userStories": [
    {
      "id": "AUTH-01",
      "title": "User registration with email verification",
      "description": "As a new user, I can register and verify my email to access the app",
      "acceptanceCriteria": [
        "Start dev server if not running (npm run dev)",
        "Launch Playwright browser in headless mode",
        "Navigate to /register page",
        "Fill email field with 'testuser@example.com'",
        "Fill password field with 'SecurePass123!'",
        "Fill confirm password field with 'SecurePass123!'",
        "Click 'Register' button",
        "Intercept API call to POST /api/auth/register",
        "Verify API returns 201 status with user data",
        "Verify redirect to /verify page occurs",
        "Verify success message 'Check your email' is displayed",
        "Take screenshot to confirm verification pending state"
      ],
      "priority": 1,
      "passes": false,
      "notes": "",
      "dependsOn": [],
      "metadata": {
        "category": "Authentication",
        "fullStack": true,
        "backend": {
          "endpoints": ["POST /api/auth/register", "GET /api/auth/verify/:token"],
          "models": ["User"],
          "validations": ["email format", "password strength", "unique email"]
        },
        "frontend": {
          "pages": ["/register", "/verify"],
          "components": ["RegisterForm", "EmailVerification"],
          "state": ["authContext.user", "authContext.isVerified"]
        },
        "playwrightTest": "tests/e2e/auth.spec.ts#registration"
      }
    },
    {
      "id": "AUTH-02",
      "title": "User login with credentials",
      "description": "As a returning user, I can log in with my credentials",
      "acceptanceCriteria": [
        "Launch Playwright browser in headless mode",
        "Navigate to /login page",
        "Fill email field with valid credentials",
        "Fill password field with valid credentials",
        "Click 'Login' button",
        "Intercept API call to POST /api/auth/login",
        "Verify API returns 200 status with JWT token",
        "Verify redirect to /dashboard occurs",
        "Verify user name appears in header/nav",
        "Take screenshot to confirm logged-in state"
      ],
      "priority": 1,
      "passes": false,
      "notes": "",
      "dependsOn": ["AUTH-01"],
      "metadata": {
        "category": "Authentication",
        "fullStack": true,
        "backend": {
          "endpoints": ["POST /api/auth/login"],
          "models": ["User", "Session"],
          "validations": ["credentials match", "account active"]
        },
        "frontend": {
          "pages": ["/login", "/dashboard"],
          "components": ["LoginForm", "Header"],
          "state": ["authContext.user", "authContext.isAuthenticated"]
        },
        "playwrightTest": "tests/e2e/auth.spec.ts#login"
      }
    },
    {
      "id": "DATA-01",
      "title": "View list of items",
      "description": "As an authenticated user, I can view a paginated list of items",
      "acceptanceCriteria": [
        "Complete AUTH-02 to be logged in",
        "Navigate to /items page",
        "Intercept API call to GET /api/items",
        "Verify API returns 200 status with paginated data",
        "Verify items list is rendered with correct count",
        "Verify pagination controls are visible",
        "Click 'Next' pagination button",
        "Verify API called with page=2 parameter",
        "Verify list updates with new items",
        "Take screenshot of paginated list"
      ],
      "priority": 2,
      "passes": false,
      "notes": "",
      "dependsOn": ["AUTH-02"],
      "metadata": {
        "category": "Data Operations",
        "fullStack": true,
        "backend": {
          "endpoints": ["GET /api/items"],
          "models": ["Item"],
          "validations": ["pagination params", "auth required"]
        },
        "frontend": {
          "pages": ["/items"],
          "components": ["ItemList", "Pagination"],
          "state": ["itemsContext.items", "itemsContext.page"]
        },
        "playwrightTest": "tests/e2e/data.spec.ts#listItems"
      }
    }
  ],
  "metadata": {
    "verificationType": "Playwright E2E Browser Automation",
    "baseUrl": "http://localhost:3000",
    "apiBaseUrl": "http://localhost:3001/api",
    "headless": true,
    "framework": "playwright",
    "instructions": "Each story must be verified using Playwright in headless mode. Launch browser, perform actions, intercept API calls, and take screenshots to confirm the complete user flow works end-to-end.",
    "analyzedAt": "ISO timestamp",
    "frontendFramework": "detected framework",
    "backendFramework": "detected framework",
    "totalEndpoints": 0,
    "totalPages": 0,
    "totalStories": 0
  }
}
```

### prd.json Location

Save the output to: `./tasks/fullstack-e2e-prd.json`

---

## Execution Workflow

### Step 1: Analyze the Codebase

```bash
# Skill automatically:
# 1. Explores backend structure
# 2. Explores frontend structure
# 3. Maps API contracts
# 4. Generates unified stories
# 5. Creates prd.json for ralph-tui
```

### Step 2: Generate Output Files

The skill creates:

```
tasks/
└── fullstack-e2e-prd.json    # ralph-tui compatible PRD

tests/
└── e2e/
    ├── auth.spec.ts          # AUTH-* stories
    ├── user.spec.ts          # USER-* stories
    ├── data.spec.ts          # DATA-* stories
    ├── forms.spec.ts         # FORM-* stories
    └── navigation.spec.ts    # NAV-* stories
```

### Step 3: Run with ralph-tui (Headless Mode)

**IMPORTANT**: After generating the prd.json, execute with ralph-tui in headless mode:

```bash
# Install Playwright if needed (one-time setup)
npm install -D @playwright/test
npx playwright install chromium

# Start your dev server (if not already running)
npm run dev &

# Run ralph-tui with the generated PRD in headless mode
ralph-tui run --prd ./tasks/fullstack-e2e-prd.json --headless
```

### ralph-tui Command Reference

| Command | Description |
|---------|-------------|
| `ralph-tui run --prd <path>` | Run PRD with interactive UI |
| `ralph-tui run --prd <path> --headless` | Run PRD in headless mode (no browser UI) |
| `ralph-tui run --prd <path> --headless --parallel` | Run independent stories in parallel |
| `ralph-tui run --prd <path> --headless --story AUTH-01` | Run specific story only |
| `ralph-tui run --prd <path> --headless --category AUTH` | Run all stories in category |

### Step 4: Manual Playwright Execution (Alternative)

If not using ralph-tui, run Playwright tests directly:

```bash
# Run all E2E tests in headless mode (default)
npx playwright test

# Run specific category
npx playwright test tests/e2e/auth.spec.ts

# Run with visible browser for debugging
npx playwright test --headed

# Run with UI mode for debugging
npx playwright test --ui
```

---

## Playwright Configuration Template

Generate this if not present:

```typescript
// playwright.config.ts
import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './tests/e2e',
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 1 : undefined,
  reporter: 'html',

  use: {
    baseURL: 'http://localhost:3000',
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
  },

  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
  ],

  webServer: {
    command: 'npm run dev',
    url: 'http://localhost:3000',
    reuseExistingServer: !process.env.CI,
  },
});
```

---

## Analysis Process

Follow this systematic approach:

### 1. Initial Exploration (Parallel)

Launch two Explore agents in parallel:
- Agent 1: Backend analysis
- Agent 2: Frontend analysis

### 2. Integration Mapping

After both complete:
- Cross-reference API endpoints with frontend calls
- Identify data contracts
- Map authentication flows end-to-end

### 3. Story Generation

For each feature area:
- Create integrated user story
- Define backend requirements
- Define frontend requirements
- Write Playwright acceptance criteria

### 4. Test File Creation

Generate Playwright test files:
- One file per category
- Tests match story IDs
- Include API interception for full-stack verification

### 5. Output Summary

Create these files:
- `tasks/fullstack-e2e-prd.json` - **ralph-tui compatible PRD** (REQUIRED final output)
- `tests/e2e/*.spec.ts` - Playwright test files for direct execution
- `STORIES.md` - Human-readable story document

**CRITICAL**: The `prd.json` is the primary deliverable. Always generate this file.

---

## Important Guidelines

- **Analyze both sides**: Don't skip backend or frontend analysis
- **Map contracts**: Verify frontend expectations match backend responses
- **Test full flows**: Each test should cover UI → API → Database → Response → UI
- **Use Playwright**: Per user preference, use Playwright over Chrome MCP
- **Isolate tests**: Each test should be independent, use `beforeEach` for setup
- **Handle async**: Always await Playwright actions and use proper waits
- **Screenshot failures**: Configure screenshots on test failure for debugging
- **Verify API calls**: Intercept and assert on API responses, not just UI

---

## Exclusions

Skip these during analysis:
- `node_modules/`, `vendor/` - Dependencies
- `dist/`, `build/`, `.next/` - Build outputs
- `*.test.*`, `*.spec.*` - Existing test files (read but don't extract stories from)
- Migration files - Schema changes (note but don't create stories for)
- Generated files - GraphQL types, API clients

---

## Starting the Analysis

Begin by:

1. Acknowledging the fullstack E2E analysis
2. Launching parallel Explore agents for backend and frontend
3. Mapping integration points between them
4. Generating unified user stories with Playwright criteria
5. Creating the `tasks/fullstack-e2e-prd.json` file (ralph-tui compatible)
6. Optionally creating Playwright test files for each category
7. Presenting the ralph-tui command to run in headless mode

**FINAL OUTPUT MUST INCLUDE:**

```bash
# Generated prd.json location
./tasks/fullstack-e2e-prd.json

# Command to run with ralph-tui in headless mode
ralph-tui run --prd ./tasks/fullstack-e2e-prd.json --headless
```

Remember: The goal is comprehensive E2E coverage that validates the entire user journey from UI interaction through API to database and back. The prd.json enables automated execution via ralph-tui.
