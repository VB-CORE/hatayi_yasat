#!/usr/bin/env bash
# Medium gorselleri: cover + figure1 + figure4 -> PNG (headless Chrome + sips)
# Kullanim: ./docs/assets/render_figures.sh [cover figure1 figure4]
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CHROME="${CHROME:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"
[[ -x "$CHROME" ]] || { echo "Chrome bulunamadi: $CHROME"; exit 1; }

# isim:html:genislik:yukseklik
declare -a FIGS=(
  "cover:cover.html:1500:750"
  "figure1_app:figure1_app.html:1600:1120"
  "figure3_key_vs_semantics:figure3_key_vs_semantics.html:1600:610"
  "figure4_contactsheet:figure4_contactsheet.html:1600:1030"
)

targets=("$@")

for spec in "${FIGS[@]}"; do
  IFS=':' read -r name html w h <<< "$spec"

  if [[ ${#targets[@]} -gt 0 ]]; then
    match=0
    for t in "${targets[@]}"; do [[ "$name" == "$t"* ]] && match=1; done
    [[ "$match" -eq 1 ]] || continue
  fi

  out="$DIR/${name}_${w}x${h}.png"

  # headless=old viewport'u pencereden 82px kisa dondurur.
  "$CHROME" --headless=old --disable-gpu --hide-scrollbars \
    --window-size="${w},$((h + 82))" --screenshot="$out" \
    "file://$DIR/$html" >/dev/null 2>&1

  got="$(sips -g pixelHeight "$out" | awk '/pixelHeight/{print $2}')"
  [[ "$got" == "$h" ]] || sips -c "$h" "$w" --cropOffset 0 0 "$out" --out "$out" >/dev/null

  echo "$(basename "$out") -> $(sips -g pixelWidth -g pixelHeight "$out" | awk '/pixelWidth/{w=$2}/pixelHeight/{print w"x"$2}')"
done
