#!/usr/bin/env bash
# thumb_*.svg -> 1280x720 PNG (headless Chrome + sips)
# Kullanim: ./docs/assets/thumbnail/render.sh [thumb_a thumb_b ...]
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CHROME="${CHROME:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"
[[ -x "$CHROME" ]] || { echo "Chrome bulunamadi: $CHROME"; exit 1; }

targets=("${@:-}")
[[ -z "${targets[0]}" ]] && targets=(thumb_a thumb_b)

for f in "${targets[@]}"; do
  svg="$DIR/$f.svg"
  [[ -f "$svg" ]] || { echo "atlandi: $f.svg yok"; continue; }
  html="$DIR/_render_$f.html"

  # SVG'yi HTML'e INLINE et: <img src="*.svg"> baglaminda tarayici SVG icindeki
  # dis <image href="app.png"> kaynaklarini yuklemez. Inline SVG'de yukler.
  {
    printf '<!doctype html><html><head><meta charset="utf-8"><style>'
    printf 'html,body{margin:0;padding:0;overflow:hidden;background:#0A0E14}'
    printf 'svg{display:block;margin-top:82px}'
    printf '</style></head><body>'
    cat "$svg"
    printf '</body></html>'
  } > "$html"

  # Chrome headless viewport'u pencereden 82px kisa doner; 884 pencere + 82px
  # ust bosluk + ortadan 720 kirpim = tam kadraj. Bu sayilari degistirme.
  "$CHROME" --headless=old --disable-gpu --hide-scrollbars \
    --window-size=1280,884 --screenshot="$DIR/${f}_1280x720.png" \
    "file://$html" >/dev/null 2>&1

  sips -c 720 1280 "$DIR/${f}_1280x720.png" --out "$DIR/${f}_1280x720.png" >/dev/null
  rm -f "$html"
  echo "$(sips -g pixelWidth -g pixelHeight "$DIR/${f}_1280x720.png" | tr '\n' ' ')"
done
