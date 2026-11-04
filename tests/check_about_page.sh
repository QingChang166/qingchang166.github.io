#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

for file in about.qmd docs/about.html; do
  for phrase in \
    'Research data scientist and computational social scientist' \
    'Hub for AI and Data Science Leadership (HAIL)' \
    'https://michaelcolaresi.com/redscaip' \
    'https://sites.pitt.edu/~mrfrank/resilientEconomy.html' \
    'I use AI, data, and rigorous social science methods to generate credible evidence on industrial policy, technological innovation, talent flows, and conflict.' \
    'Ph.D.' \
    'in Political Science from the University of Pittsburgh' \
    'Duke University' \
    'North Carolina State University' \
    'Qing1.png' \
    'Portrait of Qing Chang'; do
    if ! grep -Fq -- "$phrase" "$repo_root/$file"; then
      printf 'Missing "%s" in %s\n' "$phrase" "$file" >&2
      exit 1
    fi
  done

  for phrase in 'Postdoctoral Researcher' 'My Expertise' 'Recent Works' 'Resileient' 'Workforce Development' 'publication_1' 'quarto-about-trestles' '<figcaption>'; do
    if grep -Fq -- "$phrase" "$repo_root/$file"; then
      printf 'Unexpected legacy content "%s" in %s\n' "$phrase" "$file" >&2
      exit 1
    fi
  done
done

grep -Fq -- 'asset/about.css' "$repo_root/docs/about.html"
cmp "$repo_root/asset/about.css" "$repo_root/docs/asset/about.css"
printf 'About page checks passed.\n'
