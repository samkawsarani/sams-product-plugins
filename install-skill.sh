#!/bin/sh
# install-skill.sh — Install individual Claude Code skills from this repo
# Usage: ./install-skill.sh [OPTIONS] [SKILL_NAME ...]
set -e

# --- Resolve repo root from script location ---
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLUGINS_DIR="$SCRIPT_DIR/plugins"

if [ ! -d "$PLUGINS_DIR" ]; then
  echo "Error: plugins/ directory not found at $PLUGINS_DIR" >&2
  echo "This script must be run from the cloned sams-product-plugins repo." >&2
  exit 1
fi

# --- Defaults ---
SCOPE="user"
FORCE=0
LIST=0
ALL=0
SKILLS=""

# --- Usage ---
usage() {
  cat <<'USAGE'
Usage: install-skill.sh [OPTIONS] [SKILL_NAME ...]

Install Claude Code skills directly into your skills directory.

Options:
  --list          List available skills
  --scope SCOPE   "user" (default, ~/.claude) or "project" (./.claude)
  --all           Install all skills
  --force         Overwrite existing skills without prompting
  --help          Show this help message

Examples:
  ./install-skill.sh commit push create-pr
  ./install-skill.sh --scope project write-doc
  ./install-skill.sh --all
  ./install-skill.sh --list
USAGE
}

# --- Parse args ---
while [ $# -gt 0 ]; do
  case "$1" in
    --list)
      LIST=1
      shift
      ;;
    --scope)
      SCOPE="$2"
      shift 2
      ;;
    --all)
      ALL=1
      shift
      ;;
    --force)
      FORCE=1
      shift
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    -*)
      echo "Error: Unknown option '$1'" >&2
      usage >&2
      exit 1
      ;;
    *)
      SKILLS="$SKILLS $1"
      shift
      ;;
  esac
done

# --- Validate scope ---
if [ "$SCOPE" != "user" ] && [ "$SCOPE" != "project" ]; then
  echo "Error: --scope must be 'user' or 'project'" >&2
  exit 1
fi

# --- Build available skills list ---
available_skills() {
  for plugin_dir in "$PLUGINS_DIR"/*/; do
    name="$(basename "$plugin_dir")"
    skill_md="$plugin_dir/skills/$name/SKILL.md"
    if [ -f "$skill_md" ]; then
      echo "$name"
    fi
  done
}

# --- Get description from plugin.json ---
get_description() {
  plugin_json="$PLUGINS_DIR/$1/.claude-plugin/plugin.json"
  if [ -f "$plugin_json" ]; then
    sed -n 's/.*"description"[[:space:]]*:[[:space:]]*"\(.*\)".*/\1/p' "$plugin_json" | head -1
  else
    echo "(no description)"
  fi
}

# --- Dependency hints ---
print_dep_hints() {
  skill="$1"
  case "$skill" in
    analyze-research|weekly-recap|weekly-review|write-dev-docs|write-doc)
      echo "    Requires: qmd CLI" ;;
    daily-pulse)
      echo "    Requires: gws CLI, MCP task tools (https://github.com/samkawsarani/sams-product-os)" ;;
    write-comms)
      echo "    Requires: gws CLI" ;;
    create-pr)
      echo "    Requires: gh (GitHub CLI), git" ;;
    commit|push)
      echo "    Requires: git" ;;
    analyze-metrics)
      echo "    Requires: Python 3" ;;
    build-prototype)
      echo "    Requires: Python 3, Node.js/npx" ;;
    sync-granola-meetings)
      echo "    Requires: Granola MCP" ;;
    analyze-competitor)
      echo "    Optional: Notion MCP" ;;
  esac
}

# --- List mode ---
if [ "$LIST" = 1 ] || { [ "$ALL" = 0 ] && [ -z "$SKILLS" ]; }; then
  echo "Available skills:"
  echo ""
  for name in $(available_skills); do
    desc="$(get_description "$name")"
    printf "  %-25s %s\n" "$name" "$desc"
  done
  echo ""
  echo "Usage: $0 <skill-name> [<skill-name> ...]"
  exit 0
fi

# --- Resolve target directory ---
if [ "$SCOPE" = "user" ]; then
  TARGET_BASE="$HOME/.claude/skills"
else
  TARGET_BASE="./.claude/skills"
fi

# --- Build install list ---
if [ "$ALL" = 1 ]; then
  INSTALL_LIST="$(available_skills)"
else
  INSTALL_LIST="$(echo "$SKILLS" | tr ' ' '\n' | sed '/^$/d')"
fi

# --- Validate all skill names before installing ---
AVAILABLE="$(available_skills)"
for skill in $INSTALL_LIST; do
  found=0
  for avail in $AVAILABLE; do
    if [ "$skill" = "$avail" ]; then
      found=1
      break
    fi
  done
  if [ "$found" = 0 ]; then
    echo "Error: '$skill' is not a valid skill." >&2
    echo "Run '$0 --list' to see available skills." >&2
    exit 1
  fi
done

# --- Install ---
mkdir -p "$TARGET_BASE"
installed=0

for skill in $INSTALL_LIST; do
  src="$PLUGINS_DIR/$skill/skills/$skill"
  dest="$TARGET_BASE/$skill"

  if [ -d "$dest" ] && [ "$FORCE" = 0 ]; then
    if [ -t 0 ]; then
      printf "  '%s' already exists. Overwrite? [y/N] " "$skill"
      read -r answer
      case "$answer" in
        [yY]*) ;;
        *) echo "  Skipped $skill"; continue ;;
      esac
    else
      echo "  Skipped $skill (already exists, use --force to overwrite)"
      continue
    fi
  fi

  rm -rf "$dest"
  cp -R "$src" "$dest"

  # Make scripts executable
  if [ -d "$dest/scripts" ]; then
    find "$dest/scripts" -type f -exec chmod +x {} +
  fi

  echo "  Installed $skill"
  print_dep_hints "$skill"
  installed=$((installed + 1))
done

echo ""
echo "$installed skill(s) installed to $TARGET_BASE"
