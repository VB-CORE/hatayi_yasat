#!/bin/bash
set -euo pipefail

# Generated files are excluded in analysis_options.yaml so they stay out of the
# IDE's Problems panel. They are not committed either, which leaves CI as the
# only place a generated file going stale against its generator can be caught.
# So drop just those exclude lines here, analyze, then put them back.

cd "$(dirname "$0")/.."

options=analysis_options.yaml
backup=$(mktemp)
cp "$options" "$backup"
trap 'cp "$backup" "$options"; rm -f "$backup"' EXIT

sed -E '/^[[:space:]]*- "\*\*\.(g|gen|freezed)\.dart"$/d' "$options" >"$options.tmp"
mv "$options.tmp" "$options"

flutter analyze --no-pub --no-fatal-infos --no-fatal-warnings
