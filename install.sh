#!/bin/sh

set -eu

url="https://github.com/DietrichGebert/ponytail/archive/refs/heads/main.tar.gz"
destination=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
temporary_directory=$(mktemp -d)
trap 'rm -rf "$temporary_directory"' EXIT HUP INT TERM

if command -v curl >/dev/null 2>&1; then
  curl -fsSL "$url" -o "$temporary_directory/ponytail.tar.gz"
elif command -v wget >/dev/null 2>&1; then
  wget -qO "$temporary_directory/ponytail.tar.gz" "$url"
else
  echo "curl または wget が必要です。" >&2
  exit 1
fi

tar -xzf "$temporary_directory/ponytail.tar.gz" -C "$temporary_directory"

for skill in ponytail ponytail-audit ponytail-debt ponytail-gain ponytail-help ponytail-review; do
  source_directory="$temporary_directory/ponytail-main/skills/$skill"
  test -f "$source_directory/SKILL.md"
  mkdir -p "$destination/$skill"
  cp -R "$source_directory/." "$destination/$skill/"
done
