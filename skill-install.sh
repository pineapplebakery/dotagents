#!/bin/bash

set -euo pipefail

repository_directory=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
destination="$repository_directory/skills"
temporary_directory=$(mktemp -d)
trap 'rm -rf "$temporary_directory"' EXIT HUP INT TERM

if command -v curl >/dev/null 2>&1; then
  download() { curl -fsSL "$1" -o "$2"; }
elif command -v wget >/dev/null 2>&1; then
  download() { wget -qO "$2" "$1"; }
else
  echo "curl or wget is required." >&2
  exit 1
fi

download "https://github.com/DietrichGebert/ponytail/archive/refs/heads/main.tar.gz" "$temporary_directory/ponytail.tar.gz"
download "https://github.com/humanlayer/skills/archive/refs/heads/main.tar.gz" "$temporary_directory/show-me.tar.gz"
download "https://github.com/anthropics/claude-plugins-community/archive/refs/heads/main.tar.gz" "$temporary_directory/eli5.tar.gz"

tar -xzf "$temporary_directory/ponytail.tar.gz" -C "$temporary_directory"
tar -xzf "$temporary_directory/show-me.tar.gz" -C "$temporary_directory"
tar -xzf "$temporary_directory/eli5.tar.gz" -C "$temporary_directory"

copy_skill() {
  local source_directory=$1
  local skill=$2

  test -f "$source_directory/SKILL.md"
  mkdir -p "$destination/$skill"
  cp -R "$source_directory/." "$destination/$skill/"
}

# Ponytail has many skills, but only the selected workflows are installed.
ponytail_skills=(
  ponytail
  ponytail-audit
  ponytail-debt
  # ponytail-gain  # Disabled because its benchmark evidence is not included in the installed Skill.
  # ponytail-help  # Disabled because its auto-update guidance bypasses this reviewed installer.
  ponytail-review
)
for skill in "${ponytail_skills[@]}"; do
  copy_skill "$temporary_directory/ponytail-main/skills/$skill" "$skill"
done

copy_skill "$temporary_directory/skills-main/plugins/show-me/skills/show-me" show-me
copy_skill "$temporary_directory/claude-plugins-community-main/eli5/skills/eli5" eli5
