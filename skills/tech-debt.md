---
name: tech-debt
description: Analyze codebase for technical debt including duplication, unnecessary methods, and refactoring opportunities
triggers:
  - analyze tech debt
  - find duplication
  - check for code debt
  - refactor opportunities
  - reduce tech debt
  - code quality analysis
---

# Technical Debt Analysis Skill

You are now in technical debt analysis mode. Your goal is to perform a comprehensive analysis of the codebase to identify technical debt and provide actionable recommendations.

## Analysis Areas

Perform a thorough analysis covering these key areas:

### 1. Code Duplication
- Search for duplicate code blocks (3+ lines that appear multiple times)
- Identify similar functions/methods with slight variations
- Find repeated logic that could be extracted into shared utilities
- Look for copy-pasted code with minor modifications

### 2. Unnecessary/Dead Code
- Find unused functions, methods, classes, and variables
- Identify commented-out code blocks
- Detect imports that are never used
- Look for deprecated code that's no longer called

### 3. Complexity & Refactoring Opportunities
- Identify overly complex functions (too many branches, deep nesting)
- Find long functions/methods that should be broken down
- Spot functions doing too many things (violating single responsibility)
- Identify deeply nested conditionals or loops

### 4. Code Smells
- Look for magic numbers/strings that should be constants
- Find inconsistent naming conventions
- Identify missing error handling
- Spot hardcoded values that should be configurable
- Find overly broad exception catching

### 5. Architectural Issues
- Identify tight coupling between modules
- Find circular dependencies
- Spot violations of separation of concerns
- Identify missing abstractions or over-abstraction

## Analysis Process

Follow this systematic approach:

1. **Explore the codebase structure**
   - Use the Task tool with subagent_type=Explore to understand the project layout
   - Identify the main source directories and file types
   - Note the primary programming languages and frameworks

2. **Search for specific patterns**
   - Use Grep to search for code smell patterns
   - Use Glob to identify similar file structures
   - Read key files to understand context

3. **Analyze findings**
   - Group similar issues together
   - Prioritize by impact (high/medium/low)
   - Estimate effort to fix (quick win vs. major refactor)

4. **Generate report**
   - Create a structured markdown report with findings
   - Include specific file locations with line numbers
   - Provide concrete refactoring suggestions
   - Prioritize recommendations

## Output Format

Present findings in this format:

```markdown
# Technical Debt Analysis Report

Generated: [Date]

## Executive Summary
- Total issues found: [count]
- High priority: [count]
- Medium priority: [count]
- Low priority: [count]

## Findings by Category

### 1. Code Duplication (Priority: High/Medium/Low)

#### Issue: [Brief description]
- **Location**: file.ext:line_number, file2.ext:line_number
- **Description**: [Detailed explanation]
- **Recommendation**: [Specific refactoring suggestion]
- **Effort**: Quick Win / Medium / Large
- **Impact**: High / Medium / Low

### 2. Unnecessary Code

[Same format as above]

### 3. Complexity Issues

[Same format as above]

### 4. Code Smells

[Same format as above]

### 5. Architectural Issues

[Same format as above]

## Quick Wins
[List of high-impact, low-effort improvements]

## Recommended Action Plan
1. [Prioritized steps]
2. [...]

## Excluded from Analysis
[Files/directories intentionally skipped and why]
```

## Important Guidelines

- **Be thorough**: Use the Explore agent to systematically analyze the codebase
- **Be specific**: Always include file paths with line numbers (file.ext:line_number format)
- **Be actionable**: Provide concrete suggestions, not just observations
- **Be prioritized**: Focus on high-impact issues first
- **Be respectful**: Frame findings constructively, not critically
- **Skip generated code**: Ignore build outputs, vendored code, and dependencies
- **Consider context**: Don't flag intentional patterns or framework requirements

## Exclusions

Skip these unless explicitly requested:
- `node_modules/`, `vendor/`, `packages/` (dependencies)
- Build outputs (`dist/`, `build/`, `target/`)
- Generated files (`.min.js`, compiled files)
- Test fixtures and mock data
- Third-party code

## Starting the Analysis

Begin by:
1. Acknowledging the tech debt analysis
2. Using the Explore agent to understand the codebase
3. Performing systematic searches for each category
4. Compiling findings into the structured report
5. Presenting the report with actionable recommendations

Remember: The goal is to help improve code quality, not to criticize. Frame everything as opportunities for improvement.
