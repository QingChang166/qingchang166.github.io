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

line_number() {
  local file="$1"
  local needle="$2"
  grep -nF -- "$needle" "$repo_root/$file" | head -n 1 | cut -d: -f1
}

check_order() {
  local file="$1"
  local first="$2"
  local second="$3"
  local first_line
  local second_line
  first_line="$(line_number "$file" "$first")"
  second_line="$(line_number "$file" "$second")"

  if [ -z "$first_line" ] || [ -z "$second_line" ] || [ "$first_line" -ge "$second_line" ]; then
    printf 'Expected "%s" to appear before "%s" in %s\n' "$first" "$second" "$file" >&2
    exit 1
  fi
}

if [ -f "$repo_root/research.qmd" ]; then
  printf 'Standalone Research Themes page should be removed.\n' >&2
  exit 1
fi

if [ -f "$repo_root/docs/research.html" ]; then
  printf 'Stale rendered Research Themes page should be removed.\n' >&2
  exit 1
fi

check_contains "articles.qmd" 'title: "Research"'
check_contains "articles.qmd" "Published articles"
check_contains "articles.qmd" "Working papers"
check_contains "articles.qmd" "listing-page"
check_contains "articles.qmd" "paper-entry"
check_contains "articles.qmd" "paper-copy"
check_contains "articles.qmd" "paper-figure"
check_contains "articles.qmd" "paper-figure-button"
check_contains "articles.qmd" "data-lightbox-src"
check_contains "articles.qmd" "js/research-lightbox.js"
check_contains "articles.qmd" "paper-links"
check_contains "articles.qmd" "author-me"
check_contains "articles.qmd" "paper-funding"
check_contains "articles.qmd" "paper-figure-empty"
check_contains "articles.qmd" "articles/published/gKRLS/featured.png"
check_contains "articles.qmd" "articles/published/political_connection/featured.png"
check_contains "articles.qmd" "articles/working/upward_mobility/featured.png"
check_contains "articles.qmd" "articles/working/develop_incentive/featured.png"
check_contains "articles.qmd" "articles/working/geo_selection/featured.png"
check_contains "articles.qmd" "articles/working/us_green_federal_investments/featured.png"
check_contains "articles.qmd" "articles/working/brains_in_motion/featured.png"
check_not_contains "articles.qmd" "projects/just_transition/featured.png"
check_not_contains "articles.qmd" "projects/conflict_forcast/featured.png"
check_contains "articles.qmd" "Published Version"
check_contains "articles.qmd" "Package on CRAN"
check_contains "articles.qmd" "Open Access"
check_contains "articles.qmd" "[Research story](projects/upward_mobility/)"
check_contains "articles.qmd" "[Research story](projects/develop_incentive/)"
check_contains "articles.qmd" "US Green Federal Investments Created Quality Green Jobs and Benefitted Fossil Fuel Workers and Communities"
check_contains "articles.qmd" "Labor Gaps in the Green Transition: Challenges and Opportunities"
check_contains "articles.qmd" "Who Powers the Energy Transition? Engineering Talent in Clean Energy R&D"
check_contains "articles.qmd" "Brains in Motion: U.S.-China Talent Flows in Strategic Technology Sectors"
check_order "articles.qmd" "Upward mobility in the green sector for frontline fossil fuel workers" "US Green Federal Investments Created Quality Green Jobs and Benefitted Fossil Fuel Workers and Communities"
check_order "articles.qmd" "US Green Federal Investments Created Quality Green Jobs and Benefitted Fossil Fuel Workers and Communities" "Promotion Incentives, Political Competition, and Public Land Prices"
check_order "articles.qmd" "Promotion Incentives, Political Competition, and Public Land Prices" "Brains in Motion: U.S.-China Talent Flows in Strategic Technology Sectors"
check_order "articles.qmd" "Brains in Motion: U.S.-China Talent Flows in Strategic Technology Sectors" "Political Selection, Resource Allocation, and Long-term Economic Growth"

if grep -Fq -- "Peer-reviewed and published work in political methodology and political economy." "$repo_root/articles.qmd"; then
  printf 'Research page still contains removed published-work description.\n' >&2
  exit 1
fi

if grep -Fq -- ":::{.eyebrow}" "$repo_root/articles.qmd"; then
  printf 'Research page still contains the small Research header.\n' >&2
  exit 1
fi

check_contains "projects.qmd" 'title: "Research Projects"'
check_contains "projects.qmd" "project-showcase"
check_contains "projects.qmd" "showcase-project"
check_contains "projects.qmd" "showcase-steps"
check_contains "projects.qmd" "Conflict Prediction: an Interactive Map"
check_contains "projects.qmd" "https://shiny.crc.pitt.edu/conflictscope/"
check_contains "projects.qmd" 'target="_blank"'
check_contains "projects.qmd" 'rel="noopener noreferrer"'
check_contains "projects.qmd" "Upward Mobility of Frontline Fossil Fuel Workers"
check_contains "projects.qmd" "projects/upward_mobility/"
check_contains "projects.qmd" "articles/working/upward_mobility/featured.png"
check_contains "projects.qmd" "Promotion Incentives, Political Competition, and Public Land Prices"
check_contains "projects.qmd" "projects/develop_incentive/"
check_contains "projects.qmd" "articles/working/develop_incentive/featured.png"
check_not_contains "projects.qmd" "Just Transition and Labor Market Dynamic"
check_not_contains "projects.qmd" "Research projects, interactive tools, and collaborative work that connect data-intensive methods with social-science questions."
check_not_contains "projects.qmd" '::: {.project-intro}'
check_not_contains "projects.qmd" "These projects include interactive tools, collaborative research infrastructure, and work that may produce multiple papers."

if [ -f "$repo_root/docs/projects.html" ]; then
  check_not_contains "docs/projects.html" "Research projects, interactive tools, and collaborative work that connect data-intensive methods with social-science questions."
  check_not_contains "docs/projects.html" "These projects include interactive tools, collaborative research infrastructure, and work that may produce multiple papers."
fi

check_contains "teaching.qmd" "Teaching"
check_contains "teaching.qmd" "course-list"
check_contains "teaching.qmd" "Quantitative methods"

check_contains "contact.qmd" 'title: "Contact"'
check_contains "contact.qmd" "Email: [qic108@pitt.edu](mailto:qic108@pitt.edu)"
check_not_contains "contact.qmd" "Collaboration, speaking, teaching, and research inquiries"
check_not_contains "contact.qmd" "For research, teaching, speaking, or collaboration inquiries"
check_not_contains "contact.qmd" "contact-grid"
check_not_contains "contact.qmd" "Google Scholar"
check_not_contains "contact.qmd" "LinkedIn"

check_contains "asset/listing-default.css" "div.quarto-post"
check_contains "asset/listing-default.css" "var(--surface)"
check_contains "asset/listing-default.css" ".paper-entry"
check_contains "asset/listing-default.css" "grid-template-columns: minmax(0, 1fr) 220px;"
check_contains "asset/listing-default.css" "background: transparent;"
check_contains "asset/listing-default.css" "border-top: 1px solid var(--border);"
check_contains "asset/listing-default.css" ".author-me"
check_contains "asset/listing-default.css" ".paper-figure"
check_contains "asset/listing-default.css" ".paper-figure-button"
check_contains "asset/listing-default.css" ".paper-figure-empty"
check_contains "asset/listing-default.css" ".paper-funding"
check_contains "asset/listing-default.css" "object-fit: contain;"
check_contains "asset/listing-default.css" "height: 124px;"
check_contains "asset/listing-default.css" ".research-lightbox"
check_contains "asset/listing-default.css" "cursor: zoom-in;"
check_contains "asset/listing-default.css" "max-height: 80vh;"
check_contains "asset/listing-default.css" ".paper-links"
check_contains "asset/listing-default.css" "rgba(244, 239, 230, 0.08)"
check_contains "asset/listing-default.css" "transform: translateY(-2px);"
check_contains "asset/listing-default.css" ".quarto-listing-category"

if grep -Fq -- "box-shadow: 0 18px 48px" "$repo_root/asset/listing-default.css"; then
  printf 'Research paper entries still use card-like shadow styling.\n' >&2
  exit 1
fi

check_contains "js/research-lightbox.js" "research-lightbox"
check_contains "js/research-lightbox.js" "Escape"
check_contains "js/research-lightbox.js" "data-lightbox-src"

if [ -f "$repo_root/docs/articles.html" ]; then
  check_not_contains "docs/articles.html" "<figcaption>"
  check_contains "docs/articles.html" "js/research-lightbox.js"
fi

check_contains "asset/listing-project.css" ".card"
check_contains "asset/listing-project.css" "var(--surface)"
check_contains "asset/listing-project.css" "transform: translateY(-2px);"
check_contains "asset/listing-project.css" ".listing-description"
check_contains "asset/listing-project.css" "@keyframes showcase-scan"
check_contains "asset/listing-project.css" ".project-showcase"
check_contains "asset/listing-project.css" ".showcase-project"
check_contains "asset/listing-project.css" "max-width: 1060px;"
check_contains "asset/listing-project.css" "grid-template-columns: minmax(200px, 0.48fr) minmax(0, 1fr);"
check_contains "asset/listing-project.css" "min-height: 210px;"
check_contains "asset/listing-project.css" "height: 210px;"
check_contains "asset/listing-project.css" "font-size: clamp(1.2rem, 1.9vw, 1.78rem);"
check_contains "asset/listing-article.css" ".quarto-categories .quarto-category a"
check_contains "asset/listing-article.css" "background: rgba(244, 239, 230, 0.06);"
check_contains "asset/listing-article.css" "#title-block-header.quarto-title-block.default"

printf 'Secondary page checks passed.\n'
