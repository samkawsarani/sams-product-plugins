---
name: commit
description: Creates conventional commits with emoji prefixes, smart commit splitting, and message formatting. Invoked when asked to commit changes, stage files, or create a git commit.
disable-model-invocation: true
allowed-tools: Bash(git *)
argument-hint: [optional commit message]
compatibility: "Requires git CLI."
---

## Context

- Current branch: !`git branch --show-current`
- Git status: !`git status --short`
- Staged diff: !`git diff --cached --stat`
- Recent commits: !`git log --oneline -5`

---

## Create Conventional Commit

Create well-formatted commits using conventional commit messages with emoji.

**IMPORTANT:** If user provided arguments: $ARGUMENTS
- **If it's a commit message, USE IT DIRECTLY** - only add emoji/type prefix if missing
- If `--no-verify`, skip pre-commit verification
- **DO NOT auto-generate a different message when user provides one**

### Workflow

#### 1. Check User-Provided Message

**If user provided a message in $ARGUMENTS:**
1. Check if it already has emoji + type prefix (e.g., "🔧 chore: message")
2. If yes, use it exactly as-is
3. If no, analyze changes to determine appropriate emoji + type, then prepend to their message
4. Skip to step 5 (create commit)

**If no message provided, follow steps 2-4 below to auto-generate.**

#### 2. Check Staged Files
- Run `git status` to check staged files
- If nothing staged, stage all modified/new files with `git add -A`

#### 3. Analyze Changes
- Run `git diff --cached` to understand what's being committed
- Detect if changes span multiple concerns (see splitting guidelines below)

#### 4. Smart Commit Splitting
If changes touch multiple unrelated concerns, suggest splitting into separate commits:

**Split when:**
- Different types of changes (feature + docs + config)
- Unrelated file groups (src/ changes + test/ changes + docs/)
- Multiple logical units that could be reverted independently

#### 5. Create Commit Message (if auto-generating)

**Format:** `<emoji> <type>: <description>`

**Commit Types & Emoji:**

| Type | Emoji | Use for |
|------|-------|---------|
| feat | ✨ | New features |
| fix | 🐛 | Bug fixes |
| docs | 📝 | Documentation |
| style | 💄 | Formatting, UI styling |
| refactor | ♻️ | Code restructuring |
| perf | ⚡️ | Performance improvements |
| test | ✅ | Tests |
| chore | 🔧 | Config, tooling, maintenance |
| ci | 👷 | CI/CD changes |
| revert | 🗑️ | Reverting changes |

**Additional emoji modifiers:**

| Emoji | Meaning |
|-------|---------|
| 💥 | Breaking change |
| 🔒️ | Security fix |
| 🚑️ | Critical hotfix |
| 🌐 | Internationalization |
| 📱 | Mobile/responsive |
| 🏗️ | Architectural change |
| 📦️ | Dependencies |

**Message guidelines:**
- Present tense, imperative mood ("add" not "added")
- First line under 72 characters
- Focus on WHY, not just WHAT
- Be specific: "fix auth token expiry" > "fix bug"

**Important:**
- Do NOT push to remote unless explicitly asked
- If splitting commits, stage and commit each group separately
- Match existing commit style in the repository when possible
- Use `git commit -m "$(cat <<'EOF'` format for multi-line messages
