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

check_contains "articles/published/gKRLS/index.qmd" "../../../asset/story.css"
check_contains "articles/published/gKRLS/index.qmd" "../../../js/story-scroll.js"
check_contains "articles/published/gKRLS/index.qmd" "paper-story"
check_contains "articles/published/gKRLS/index.qmd" "story-progress"
check_contains "articles/published/gKRLS/index.qmd" "The problem"
check_contains "articles/published/gKRLS/index.qmd" "The idea"
check_contains "articles/published/gKRLS/index.qmd" "The scaling move"
check_contains "articles/published/gKRLS/index.qmd" "What this changes"
check_contains "articles/published/gKRLS/index.qmd" "figure-panel"

check_contains "projects/upward_mobility/index.qmd" "../../asset/story.css"
check_contains "projects/upward_mobility/index.qmd" "../../js/story-scroll.js"
check_contains "projects/upward_mobility/index.qmd" "../../js/research-lightbox.js"
check_contains "projects/upward_mobility/index.qmd" "paper-story"
check_contains "projects/upward_mobility/index.qmd" "mobility-story-hero"
check_contains "projects/upward_mobility/index.qmd" "story-stat-grid"
check_contains "projects/upward_mobility/index.qmd" "story-progress"
check_contains "projects/upward_mobility/index.qmd" "scrolly-deck"
check_contains "projects/upward_mobility/index.qmd" "scrolly-stage"
check_contains "projects/upward_mobility/index.qmd" "scrolly-visual"
check_contains "projects/upward_mobility/index.qmd" "scrolly-step"
check_contains "projects/upward_mobility/index.qmd" "data-scrolly-step"
check_contains "projects/upward_mobility/index.qmd" "data-scrolly-visual"
check_contains "projects/upward_mobility/index.qmd" "data-lightbox-src"
check_contains "projects/upward_mobility/index.qmd" "scrolly-expand-hint"
check_contains "projects/upward_mobility/index.qmd" "projects/upward_mobility/figures/mobility-opportunity.png"
check_contains "projects/upward_mobility/index.qmd" "projects/upward_mobility/figures/career-wage-gains.png"
check_contains "projects/upward_mobility/index.qmd" "projects/upward_mobility/figures/skill-pathways.png"
check_contains "projects/upward_mobility/index.qmd" "The question"
check_contains "projects/upward_mobility/index.qmd" "Mobility advantage"
check_contains "projects/upward_mobility/index.qmd" "Wage payoff"
check_contains "projects/upward_mobility/index.qmd" "Skill pathways"

check_contains "projects/develop_incentive/index.qmd" "../../asset/story.css"
check_contains "projects/develop_incentive/index.qmd" "../../js/story-scroll.js"
check_contains "projects/develop_incentive/index.qmd" "../../js/research-lightbox.js"
check_contains "projects/develop_incentive/index.qmd" "paper-story"
check_contains "projects/develop_incentive/index.qmd" "land-story"
check_contains "projects/develop_incentive/index.qmd" "mobility-story-hero"
check_contains "projects/develop_incentive/index.qmd" "story-stat-grid"
check_contains "projects/develop_incentive/index.qmd" "story-progress"
check_contains "projects/develop_incentive/index.qmd" "scrolly-deck"
check_contains "projects/develop_incentive/index.qmd" "scrolly-stage"
check_contains "projects/develop_incentive/index.qmd" "scrolly-visual"
check_contains "projects/develop_incentive/index.qmd" "scrolly-step"
check_contains "projects/develop_incentive/index.qmd" "scrolly-inline-visual"
check_contains "projects/develop_incentive/index.qmd" "data-scrolly-step"
check_contains "projects/develop_incentive/index.qmd" "data-scrolly-visual"
check_contains "projects/develop_incentive/index.qmd" "data-lightbox-src"
check_contains "projects/develop_incentive/index.qmd" "scrolly-expand-hint"
check_contains "projects/develop_incentive/index.qmd" "projects/develop_incentive/figures/compensation-gap.png"
check_contains "projects/develop_incentive/index.qmd" "projects/develop_incentive/figures/land-market-expansion.png"
check_contains "projects/develop_incentive/index.qmd" "projects/develop_incentive/figures/border-identification.png"
check_contains "projects/develop_incentive/index.qmd" "projects/develop_incentive/figures/protest-mediation.png"
check_contains "projects/develop_incentive/index.qmd" "The puzzle"
check_contains "projects/develop_incentive/index.qmd" "Land becomes the pressure valve"
check_contains "projects/develop_incentive/index.qmd" "A border design turns politics into comparison"
check_contains "projects/develop_incentive/index.qmd" "From price intervention to protest"

check_contains "asset/story.css" ".paper-story"
check_contains "asset/story.css" ".mobility-story-hero"
check_contains "asset/story.css" ".story-stat-grid"
check_contains "asset/story.css" ".land-story"
check_contains "asset/story.css" ".scrolly-inline-visual"
check_contains "asset/story.css" ".scrolly-deck"
check_contains "asset/story.css" "max-width: min(1320px, calc(100vw - 3rem));"
check_contains "asset/story.css" "grid-template-columns: minmax(0, 1.65fr) minmax(300px, 0.58fr);"
check_contains "asset/story.css" ".scrolly-stage"
check_contains "asset/story.css" ".scrolly-visual"
check_contains "asset/story.css" ".scrolly-step"
check_contains "asset/story.css" ".scrolly-expand-hint"
check_contains "asset/story.css" "cursor: zoom-in;"
check_contains "asset/story.css" "position: sticky;"
check_contains "asset/story.css" "min-height: 85vh;"
check_contains "asset/story.css" "max-height: 82vh;"
check_contains "asset/story.css" "max-height: 34vh;"
check_contains "asset/story.css" ".story-step"
check_contains "asset/story.css" ".figure-panel"
check_contains "asset/story.css" ".figure-panel-wide"
check_contains "asset/story.css" "prefers-reduced-motion"

check_contains "js/story-scroll.js" "IntersectionObserver"
check_contains "js/story-scroll.js" "is-visible"
check_contains "js/story-scroll.js" "scrolly-step"
check_contains "js/story-scroll.js" "scrolly-visual"
check_contains "js/story-scroll.js" "data-scrolly-step"
check_contains "js/story-scroll.js" "is-active"
check_contains "js/story-scroll.js" "activateScrollyStep(scrollySteps[0])"
check_contains "js/story-scroll.js" "story-progress"
check_contains "js/research-lightbox.js" "keydown"
check_contains "js/research-lightbox.js" "Enter"
check_contains "js/research-lightbox.js" " "

if [ -f "$repo_root/docs/projects/upward_mobility/index.html" ]; then
  check_not_contains "docs/projects/upward_mobility/index.html" "<figcaption>"
  check_not_contains "docs/projects/upward_mobility/index.html" '&lt;figure class="scrolly-visual'
  check_not_contains "docs/projects/upward_mobility/index.html" '&lt;article class="scrolly-step'
fi

if [ -f "$repo_root/docs/projects/develop_incentive/index.html" ]; then
  check_not_contains "docs/projects/develop_incentive/index.html" "<figcaption>"
  check_not_contains "docs/projects/develop_incentive/index.html" '&lt;figure class="scrolly-visual'
  check_not_contains "docs/projects/develop_incentive/index.html" '&lt;article class="scrolly-step'
fi

printf 'Story page checks passed.\n'
