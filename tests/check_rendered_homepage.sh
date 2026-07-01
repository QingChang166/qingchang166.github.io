#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if grep -Fq -- '&lt;a class="button-link" href="research.html"&gt;' "$repo_root/docs/index.html"; then
  printf 'Homepage rendered bottom links as escaped code.\n' >&2
  exit 1
fi

if grep -Fq -- 'Featured work' "$repo_root/docs/index.html"; then
  printf 'Homepage still contains redundant Featured work section.\n' >&2
  exit 1
fi

if grep -Fq -- '<div class="eyebrow">Methods</div>' "$repo_root/docs/index.html"; then
  printf 'Homepage still contains redundant Methods section.\n' >&2
  exit 1
fi

if ! grep -Fq -- 'class="capability-console site-section"' "$repo_root/docs/index.html"; then
  printf 'Homepage is missing rendered Research Toolkit section.\n' >&2
  exit 1
fi

if ! grep -Fq -- 'styles-20260701.css' "$repo_root/docs/index.html"; then
  printf 'Homepage should reference the cache-busted stylesheet.\n' >&2
  exit 1
fi

if ! grep -Fq -- 'Research Toolkit' "$repo_root/docs/index.html"; then
  printf 'Homepage is missing rendered Research Toolkit label.\n' >&2
  exit 1
fi

if grep -Fq -- '>Capability Console<' "$repo_root/docs/index.html"; then
  printf 'Homepage still renders old Capability Console label.\n' >&2
  exit 1
fi

if grep -Fq -- 'I connect real-world data, rigorous methods, and substantive political questions' "$repo_root/docs/index.html"; then
  printf 'Homepage still renders removed toolkit subcopy.\n' >&2
  exit 1
fi

if ! grep -Fq -- 'Knowledge graph driven AI applications' "$repo_root/docs/index.html"; then
  printf 'Homepage is missing rendered knowledge graph skill area.\n' >&2
  exit 1
fi

if grep -Fq -- '<h3 class="anchored">Interdisciplinary computational social science</h3>' "$repo_root/docs/index.html"; then
  printf 'Homepage still renders duplicated right-panel skill names.\n' >&2
  exit 1
fi

if grep -Fq -- 'Research Transit Map' "$repo_root/docs/index.html"; then
  printf 'Homepage still contains old transit map copy.\n' >&2
  exit 1
fi

if grep -Fq -- 'A signal map for evidence-driven social science' "$repo_root/docs/index.html"; then
  printf 'Homepage still contains the removed research-area headline.\n' >&2
  exit 1
fi

if grep -Fq -- 'Four problem spaces organize my current agenda' "$repo_root/docs/index.html"; then
  printf 'Homepage still contains the removed research-area subcopy.\n' >&2
  exit 1
fi

if ! grep -Fq -- 'js/capability-console.js' "$repo_root/docs/index.html"; then
  printf 'Homepage is missing capability console script.\n' >&2
  exit 1
fi

if grep -Fq -- '<a class="button-link primary" href="Qing_Chang_CV.pdf">CV</a>' "$repo_root/docs/index.html"; then
  printf 'Homepage still contains duplicate CV button.\n' >&2
  exit 1
fi

if grep -Fq -- '<a class="button-link" href="mailto:qic108@pitt.edu">Email</a>' "$repo_root/docs/index.html"; then
  printf 'Homepage still contains duplicate email button.\n' >&2
  exit 1
fi

if grep -Fq -- '<h1 class="title">Qing Chang</h1>' "$repo_root/docs/index.html"; then
  printf 'Homepage still renders duplicate Quarto title block.\n' >&2
  exit 1
fi

if ! grep -Fq -- 'research-signal-map' "$repo_root/docs/index.html"; then
  printf 'Homepage is missing rendered research signal map.\n' >&2
  exit 1
fi

if ! grep -Fq -- 'I use AI, data, and rigorous social science methods to generate credible evidence on industrial policy, technological innovation, talent flows, and conflict.' "$repo_root/docs/index.html"; then
  printf 'Homepage rendered copy does not include the refined hero statement.\n' >&2
  exit 1
fi

if ! grep -Fq -- 'href="https://michaelcolaresi.com/redscaip"' "$repo_root/docs/index.html"; then
  printf 'Homepage is missing the REDSCAIP affiliate link.\n' >&2
  exit 1
fi

if ! grep -Fq -- 'href="https://sites.pitt.edu/~mrfrank/resilientEconomy.html"' "$repo_root/docs/index.html"; then
  printf 'Homepage is missing the Resilient Economy Lab affiliate link.\n' >&2
  exit 1
fi

if grep -Fq -- '>link</a>' "$repo_root/docs/index.html"; then
  printf 'Homepage still renders generic affiliate link labels.\n' >&2
  exit 1
fi

if grep -Fq -- 'research-tags' "$repo_root/docs/index.html"; then
  printf 'Homepage still renders research-area tag chips.\n' >&2
  exit 1
fi

printf 'Rendered homepage checks passed.\n'
