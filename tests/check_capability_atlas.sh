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

check_contains "index.qmd" "capability-console"
check_contains "index.qmd" "Research Toolkit"
check_contains "index.qmd" "From Complex Data to Credible Evidence"
check_contains "index.qmd" "Interdisciplinary computational social science"
check_contains "index.qmd" "Large scale structured and semi structured data"
check_contains "index.qmd" "Causal machine learning and policy inference"
check_contains "index.qmd" "Interactive visualization and research tool development"
check_contains "index.qmd" "Geospatial and network data science"
check_contains "index.qmd" "Knowledge graph driven AI applications"
check_contains "index.qmd" "I work across political science, economics, and data science"
check_contains "index.qmd" "cleaning, harmonization, linkage, validation, and documentation"
check_contains "index.qmd" "traditional causal inference tools and newer causal machine learning methods"
check_contains "index.qmd" "backend data workflows with frontend interfaces"
check_contains "index.qmd" "spatial and relational data"
check_contains "index.qmd" "knowledge graphs and AI tools"
check_contains "index.qmd" "Generalized Kernel Regularized Least Squares"
check_contains "index.qmd" "Promotion Incentives, Political Competition, and Public Land Prices"
check_contains "index.qmd" "Upward mobility in the green sector for frontline fossil fuel workers"
check_contains "index.qmd" "Conflict Prediction: an Interactive Map"
check_contains "index.qmd" "Brains in Motion: U.S.-China Talent Flows in Strategic Technology Sectors"
check_contains "index.qmd" "Who Powers the Energy Transition? Engineering Talent in Clean Energy R&amp;D"
check_contains "index.qmd" "selected-work-list"
check_contains "index.qmd" "work-type"
check_contains "index.qmd" "Selected work"
check_contains "index.qmd" "Working paper"
check_contains "index.qmd" "Published article"
check_contains "index.qmd" "Project story"
check_contains "index.qmd" "articles.html#upward-mobility-in-the-green-sector-for-frontline-fossil-fuel-workers"
check_contains "index.qmd" "articles.html#promotion-incentives-political-competition-and-public-land-prices"
check_contains "index.qmd" "articles.html#generalized-kernel-regularized-least-squares"
check_contains "index.qmd" "projects/conflict_forcast/"

if grep -Fq -- "Research story" "$repo_root/index.qmd"; then
  printf 'Homepage toolkit should not label papers as research stories.\n' >&2
  exit 1
fi

if grep -Fq -- "Interactive project" "$repo_root/index.qmd"; then
  printf 'Homepage toolkit should use Project story for the conflict map, not Interactive project.\n' >&2
  exit 1
fi

if grep -F -- 'class="selected-work" href="projects/' "$repo_root/index.qmd" | grep -Fvq 'projects/conflict_forcast/'; then
  printf 'Homepage toolkit project-story links should only point to the conflict forecasting story.\n' >&2
  exit 1
fi

tools_panel="$(awk '/id="skill-tools"/,/id="skill-geo"/' "$repo_root/index.qmd")"
if grep -Fq -- "Upward mobility in the green sector for frontline fossil fuel workers" <<<"$tools_panel"; then
  printf 'Interactive visualization skill should not list the upward mobility paper.\n' >&2
  exit 1
fi

if grep -Fq -- "Promotion Incentives, Political Competition, and Public Land Prices" <<<"$tools_panel"; then
  printf 'Interactive visualization skill should not list the promotion incentives paper.\n' >&2
  exit 1
fi

if ! grep -Fq -- "projects/conflict_forcast/" <<<"$tools_panel"; then
  printf 'Interactive visualization skill should link to the conflict forecasting project story.\n' >&2
  exit 1
fi
if grep -Fq -- "Capability Console" "$repo_root/index.qmd"; then
  printf 'Homepage still contains old Capability Console wording.\n' >&2
  exit 1
fi

if grep -Fq -- "I connect real-world data, rigorous methods, and substantive political questions" "$repo_root/index.qmd"; then
  printf 'Homepage still contains the removed toolkit subcopy.\n' >&2
  exit 1
fi

if grep -Fq -- "Data Infrastructure" "$repo_root/index.qmd"; then
  printf 'Homepage still contains old skill tab labels.\n' >&2
  exit 1
fi

if grep -Fq -- "tool-row" "$repo_root/index.qmd"; then
  printf 'Homepage still contains toolkit keyword pill rows.\n' >&2
  exit 1
fi

if grep -Fq -- "panel-links" "$repo_root/index.qmd"; then
  printf 'Homepage still contains short toolkit button links.\n' >&2
  exit 1
fi

if grep -Fq -- "panel-links" "$repo_root/styles.css"; then
  printf 'Stylesheet still contains old toolkit button link styles.\n' >&2
  exit 1
fi

if grep -Fq -- "<h3>Interdisciplinary computational social science</h3>" "$repo_root/index.qmd"; then
  printf 'Homepage still duplicates skill names inside toolkit panels.\n' >&2
  exit 1
fi

check_contains "styles.css" ".capability-console"
check_contains "styles.css" ".console-layout"
check_contains "styles.css" ".skill-tab"
check_contains "styles.css" ".capability-panel"
check_contains "styles.css" ".selected-work-list"
check_contains "styles.css" ".selected-work"
check_contains "styles.css" ".work-type"
check_contains "styles.css" "padding-bottom: 0.75rem;"
check_contains "styles.css" "padding-top: 2rem;"
check_contains "styles.css" "font-size: 0.96rem;"
check_contains "styles.css" "line-height: 1.55;"
check_contains "js/capability-console.js" "addEventListener"
check_contains "js/capability-console.js" "aria-selected"

if grep -Fq -- ".capability-panel h3" "$repo_root/styles.css"; then
  printf 'Stylesheet still contains right-panel skill heading styles.\n' >&2
  exit 1
fi

if [ -f "$repo_root/docs/index.html" ]; then
  if grep -Fq -- '&lt;section class="capability-console' "$repo_root/docs/index.html"; then
    printf 'Research Toolkit rendered as escaped code.\n' >&2
    exit 1
  fi
fi

printf 'Research Toolkit checks passed.\n'
