#!/usr/bin/env bash
set -euo pipefail

REPO="samkawsarani/sams-product-plugins"
MARKETPLACE="sams-product-plugins"

PLUGINS=(
  analyze-competitor
  analyze-metrics
  analyze-research
  build-prototype
  commit
  create-pr
  daily-pulse
  push
  translate-i18n
  weekly-recap
  weekly-review
  write-comms
  write-dev-docs
  write-doc
  write-ux-copy
)

echo "=== PM Skills Marketplace Setup ==="
echo ""

# Step 1: Add marketplace
echo "How would you like to add the marketplace?"
echo "  1) From GitHub (recommended)"
echo "  2) Clone locally first"
read -rp "Choice [1]: " method
method="${method:-1}"

if [[ "$method" == "2" ]]; then
  read -rp "Clone path [~/Projects/$MARKETPLACE]: " clone_path
  clone_path="${clone_path:-$HOME/Projects/$MARKETPLACE}"
  clone_path="${clone_path/#\~/$HOME}"
  git clone "https://github.com/$REPO" "$clone_path"
  claude plugin add "dir:$clone_path"
else
  claude plugin add "github:$REPO"
fi

echo ""

# Step 2: Choose plugins
echo "Available plugins:"
echo ""
for i in "${!PLUGINS[@]}"; do
  printf "  %2d) %s\n" $((i + 1)) "${PLUGINS[$i]}"
done
echo ""
echo "  a) All plugins"
echo ""
read -rp "Enter numbers separated by spaces, or 'a' for all: " selection

selected=()
if [[ "$selection" == "a" ]]; then
  selected=("${PLUGINS[@]}")
else
  for num in $selection; do
    idx=$((num - 1))
    if [[ $idx -ge 0 && $idx -lt ${#PLUGINS[@]} ]]; then
      selected+=("${PLUGINS[$idx]}")
    fi
  done
fi

if [[ ${#selected[@]} -eq 0 ]]; then
  echo "No plugins selected."
  exit 0
fi

echo ""
echo "Enabling ${#selected[@]} plugin(s)..."
for plugin in "${selected[@]}"; do
  claude plugin enable "${plugin}@${MARKETPLACE}"
done

# Step 3: Verify
echo ""
echo "Installed plugins:"
claude plugin list
