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

check_not_contains() {
  local file="$1"
  local needle="$2"
  if grep -Fq -- "$needle" "$repo_root/$file"; then
    printf 'Unexpected "%s" in %s\n' "$needle" "$file" >&2
    exit 1
  fi
}

check_contains "index.qmd" "site-hero"
check_contains "index.qmd" "Qing Chang"
check_contains "index.qmd" "Research data scientist and computational social scientist"
check_contains "index.qmd" "Hub for AI and Data Science Leadership (HAIL)"
check_contains "index.qmd" "Responsible Data Science, Complexity, and AI for Peace Lab"
check_contains "index.qmd" "https://michaelcolaresi.com/redscaip"
check_contains "index.qmd" "Resilient Economy Lab"
check_contains "index.qmd" "https://sites.pitt.edu/~mrfrank/resilientEconomy.html"
check_contains "index.qmd" "Qing1.png"
check_contains "index.qmd" "I use AI, data, and rigorous social science methods to generate credible evidence on industrial policy, technological innovation, talent flows, and conflict."
check_contains "index.qmd" "research-signal-map"
check_contains "index.qmd" "research-node"
check_contains "index.qmd" "AI & Energy"
check_contains "index.qmd" "Future of Work"
check_contains "index.qmd" "Graph AI & Conflict Forecasting"
check_not_contains "index.qmd" "Workforce Development"
check_contains "styles.css" "min-height: calc(74svh - 64px);"
check_contains "styles.css" "padding: clamp(0.75rem, 2.2vw, 2rem) 1.4rem 2.25rem;"
check_contains "styles.css" "font-size: clamp(1.02rem, 1.35vw, 1.22rem);"
check_contains "styles.css" "grid-template-columns: repeat(3, minmax(0, 1fr));"
check_contains "index.qmd" "capability-console"
check_contains "index.qmd" "Research Toolkit"
check_contains "index.qmd" "From Complex Data to Credible Evidence"
check_contains "index.qmd" "Interdisciplinary computational social science"
check_contains "index.qmd" "Knowledge graph driven AI applications"
check_contains "index.qmd" "skill-tab"
check_contains "index.qmd" "capability-panel"
check_contains "index.qmd" "js/capability-console.js"
check_not_contains "index.qmd" "Featured work"
check_not_contains "index.qmd" "Methods"
check_not_contains "index.qmd" "Research themes"
check_not_contains "index.qmd" "hero-actions"
check_not_contains "index.qmd" "Qing_Chang_CV.pdf"
check_not_contains "index.qmd" "mailto:qic108@pitt.edu"
check_not_contains "index.qmd" "title-block.html"
check_not_contains "index.qmd" "typewriter"
check_not_contains "index.qmd" "particles"
check_not_contains "index.qmd" "(<a href=\"https://michaelcolaresi.com/redscaip\">link</a>)"
check_not_contains "index.qmd" "(<a href=\"https://sites.pitt.edu/~mrfrank/resilientEconomy.html\">link</a>)"
check_not_contains "index.qmd" "A signal map for evidence-driven social science"
check_not_contains "index.qmd" "Four problem spaces organize my current agenda"
check_not_contains "index.qmd" "research-tags"
check_not_contains "index.qmd" "signal-axis"
check_not_contains "index.qmd" "<em>industrial policy</em>"
check_not_contains "index.qmd" "<em>talent flows</em>"
check_not_contains "index.qmd" "How data-intensive systems can explain"
check_not_contains "index.qmd" "How technological and structural change reshape"
if grep -F "Capability Console" "$repo_root/index.qmd" | grep -Fv "js/capability-console.js" >/dev/null; then
  printf 'Unexpected visible Capability Console wording in index.qmd\n' >&2
  exit 1
fi
check_not_contains "index.qmd" "real-world data, rigorous methods, and substantive political questions"
check_not_contains "index.qmd" "Data Infrastructure"
check_not_contains "index.qmd" "tool-row"
check_not_contains "styles.css" "background: rgba(16, 17, 19, 0.78);"
check_not_contains "styles.css" "border: 1px solid rgba(244, 239, 230, 0.16);"
check_not_contains "styles.css" "min-height: 112px;"

printf 'Homepage content checks passed.\n'
