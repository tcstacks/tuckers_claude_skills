---
name: frontend-integration-check
description: Verifies frontend-backend integration completeness. Use AFTER building any frontend with interactive elements. Triggers when finishing frontend work, when user reports buttons not working, when connecting frontend to backend, or on any request to verify/check/validate UI integration. Detects dead buttons, missing API routes, orphan state, empty handlers, and incomplete wiring.
---

# Frontend-Backend Integration Verification

Run this verification before marking any frontend work complete.

## Verification Steps

### 1. Audit All Interactive Elements

Scan every file for interactive components. For each one found, verify it has real functionality:

**Buttons/Clickables:**
- Every `<button>` and `<Button>` has an `onClick` that does something beyond `console.log` or `() => {}`
- Every clickable element triggers a state change, API call, or navigation

**Forms:**
- Every `<form>` has `onSubmit` with `e.preventDefault()` and actual submission logic
- Every form input has `onChange` wiring to state
- Submit buttons are `type="submit"` or have explicit handlers

**Links:**
- No `href="#"` placeholder links
- All `<Link>` components point to existing routes

### 2. Verify API Call Coverage

For every frontend API call (`fetch`, `axios`, `api.*`, `useSWR`, `useQuery`):

1. Confirm the backend route exists
2. Confirm HTTP method matches (GET/POST/etc)
3. Confirm request/response schemas align
4. Confirm error handling exists (try/catch or .catch)
5. Confirm loading state is shown during request

### 3. Verify State Completeness

For every `useState` declaration:
- The setter function is called somewhere (not orphan state)
- The state value is rendered or used somewhere
- State updates trigger expected UI changes

For every `useEffect`:
- Dependencies are correct
- Cleanup functions exist where needed

### 4. Check Handler Implementation

Flag any handler containing:
- `TODO`, `FIXME`, `XXX`, `HACK`
- Empty function body `() => {}`
- Only `console.log` statements
- `// implement later` comments

### 5. Click-Through Verification

After code review, mentally trace or actually test:
- Click every button → verify visible effect
- Submit every form → verify feedback shown
- Trigger every error state → verify message displays
- Check every loading state → verify spinner/skeleton appears

## Critical Issue Checklist

Before completion, confirm zero instances of:

- [ ] `onClick={() => {}}` (empty handler)
- [ ] `onClick={() => console.log(...)}` (log-only handler)
- [ ] `onSubmit={() => {}}` (empty form handler)
- [ ] `href="#"` (placeholder link)
- [ ] `useState` setter never called
- [ ] `fetch()` without try/catch or .catch
- [ ] API call to non-existent backend route
- [ ] TODO/FIXME inside event handlers
- [ ] Form without loading/error/success states

## Correct Patterns

### Button with Full Wiring
```tsx
const [loading, setLoading] = useState(false);
const [error, setError] = useState<string | null>(null);

const handleClick = async () => {
  setLoading(true);
  setError(null);
  try {
    const res = await fetch('/api/endpoint', { method: 'POST', body: JSON.stringify(data) });
    if (!res.ok) throw new Error('Request failed');
    // Handle success: update state, show toast, navigate, etc.
  } catch (e) {
    setError(e instanceof Error ? e.message : 'Unknown error');
  } finally {
    setLoading(false);
  }
};

<button onClick={handleClick} disabled={loading}>
  {loading ? 'Processing...' : 'Submit'}
</button>
{error && <p className="error">{error}</p>}
```

### Form with Full Wiring
```tsx
<form onSubmit={(e) => {
  e.preventDefault();
  handleSubmit();
}}>
  <input 
    value={value} 
    onChange={(e) => setValue(e.target.value)} 
    required 
  />
  <button type="submit" disabled={loading}>
    {loading ? 'Saving...' : 'Save'}
  </button>
</form>
```

## Output

After verification, report:
1. Number of interactive elements audited
2. Any critical issues found (with file:line references)
3. Any warnings (missing error handling, etc.)
4. Confirmation that all buttons/forms have real functionality
