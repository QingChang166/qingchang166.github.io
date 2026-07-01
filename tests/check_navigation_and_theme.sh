#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

check_contains() {
  local file="$1"
  local needle="$2"
  if ! grep -Fq -- "$needle" "$repo_root/$file"; then
    printf 'Missing "%s" in %s\n' "$needle" "$file" >&2
    exit 1
  fi
}

check_contains "_quarto.yml" "href: index.qmd"
check_contains "_quarto.yml" "text: Research"
check_contains "_quarto.yml" "href: articles.qmd"
check_contains "_quarto.yml" "text: Projects"
check_contains "_quarto.yml" "href: projects.qmd"
check_contains "_quarto.yml" "text: Teaching"
check_contains "_quarto.yml" "href: teaching.qmd"
check_contains "_quarto.yml" "text: CV"
check_contains "_quarto.yml" "href: Qing_Chang_CV.pdf"
check_contains "_quarto.yml" "text: Contact"
check_contains "_quarto.yml" "href: contact.qmd"
check_contains "_quarto.yml" "theme:"
check_contains "_quarto.yml" "asset/theme.scss"
check_contains "_quarto.yml" "css: styles-20260701.css"
check_contains "asset/theme.scss" "/*-- scss:defaults --*/"
check_contains "asset/theme.scss" '$body-bg: #050505;'
check_contains "asset/theme.scss" '$body-color: #f4efe6;'
check_contains "asset/theme.scss" '$navbar-bg: #050505;'
check_contains "asset/theme.scss" '$link-color: #d99358;'
check_contains "asset/theme.scss" '$dropdown-bg: #101113;'

check_contains "styles.css" "--site-bg: #050505;"
check_contains "styles-20260701.css" "--site-bg: #050505;"
check_contains "styles.css" "--text-main:"
check_contains "styles.css" ".site-hero"
check_contains "styles.css" ".research-signal-map"
check_contains "styles.css" ".story-link"
check_contains "styles.css" ".quarto-title-block.default"
check_contains "styles.css" ".quarto-listing-category"
check_contains "styles.css" "@keyframes section-rise"
check_contains "styles.css" ".capability-panel.is-active"
check_contains "styles.css" "@media (max-width: 640px)"
check_contains "styles.css" "prefers-reduced-motion"

if grep -Fq -- "href: research.qmd" "$repo_root/_quarto.yml"; then
  printf 'Navbar still links to the removed standalone Research page.\n' >&2
  exit 1
fi

if grep -Fq -- "text: Publications" "$repo_root/_quarto.yml"; then
  printf 'Navbar still uses Publications instead of Research.\n' >&2
  exit 1
fi

printf 'Navigation and theme source checks passed.\n'
