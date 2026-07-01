#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
private_pdf="FFF_CareerMobility_main.pdf"

check_contains() {
  local file="$1"
  local needle="$2"
  if ! grep -Fq -- "$needle" "$repo_root/$file"; then
    printf 'Missing "%s" in %s\n' "$needle" "$file" >&2
    exit 1
  fi
}

check_contains ".gitignore" "articles/working/upward_mobility/$private_pdf"
check_contains ".gitignore" "docs/articles/working/upward_mobility/$private_pdf"

if [ -f "$repo_root/docs/articles/working/upward_mobility/$private_pdf" ]; then
  printf 'Private upward mobility PDF was copied into docs.\n' >&2
  exit 1
fi

if grep -RIl --exclude-dir=.git --exclude-dir=tmp --exclude="$private_pdf" "$private_pdf" "$repo_root" \
  | grep -v '/tests/check_private_assets.sh$' \
  | grep -v '/.gitignore$' >/dev/null; then
  printf 'Private upward mobility PDF filename is referenced outside privacy checks.\n' >&2
  exit 1
fi

printf 'Private asset checks passed.\n'
