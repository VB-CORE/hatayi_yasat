#!/usr/bin/env bash
# Bir Maestro flow'unu kosarken simulator ekranini kaydeder ve GIF'e cevirir.
#
#   ./docs/assets/make_gif.sh <flow.yaml> <cikti-adi> [SS_BASLANGIC] [SURE] [GENISLIK] [FPS]
#
# Yazida kullanilan GIF tam olarak bu komutla uretildi (bootstrap'i atlar, sadece
# favori tur-donusunu alir: detay -> favorile -> geri -> Favoriler -> temizle):
#   ./docs/assets/make_gif.sh maestro/flows/smoke/07_favorite_add_and_list.yaml \
#       flow07_favorite 34 19 540 12
#
# Ham kayit /tmp/<ad>_raw.mov'da BIRAKILIR. Pencereyi degistirmek icin tekrar
# kayit almaya gerek yok, dogrudan o dosyadan ffmpeg ile yeniden kirp.
#
# Neden Maestro'nun kendi `record` cikitisi degil: `maestro record --local`
# terminal + telefonu yan yana basiyor ve telefon panelini sag kenardan kirpiyor.
# GIF'te terminal metni okunmaz zaten; temiz portre goruntu icin simulator'u
# dogrudan yakalamak daha iyi.
set -euo pipefail

FLOW="${1:?flow yaml yolu gerekli}"
NAME="${2:?cikti adi gerekli}"
SS="${3:-0}"
DUR="${4:-30}"
W="${5:-480}"
FPS="${6:-12}"

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$DIR/../.." && pwd)"
RAW="/tmp/${NAME}_raw.mov"
OUT="$DIR/${NAME}.gif"
PALETTE="/tmp/${NAME}_palette.png"

command -v ffmpeg >/dev/null || { echo "ffmpeg gerekli: brew install ffmpeg"; exit 1; }

DEVICE_ID="${DEVICE_ID:-$(xcrun simctl list devices booted -j \
  | python3 -c 'import json,sys; d=json.load(sys.stdin)["devices"]; print(next((x["udid"] for v in d.values() for x in v if x.get("state")=="Booted"), ""))')}"
[[ -n "$DEVICE_ID" ]] || { echo "Booted simulator yok"; exit 1; }

cd "$PROJECT_DIR"
rm -f "$RAW"

echo "▶ Ekran kaydi basliyor…"
xcrun simctl io "$DEVICE_ID" recordVideo --codec h264 --force "$RAW" &
REC_PID=$!
sleep 2

echo "▶ Flow kosuluyor: $FLOW"
set +e
maestro --device "$DEVICE_ID" test "$FLOW"
FLOW_RC=$?
set -e

sleep 1
echo "▶ Kayit durduruluyor…"
kill -INT "$REC_PID" 2>/dev/null || true
wait "$REC_PID" 2>/dev/null || true
sleep 1

[[ -s "$RAW" ]] || { echo "Kayit olusmadi: $RAW"; exit 1; }
TOTAL="$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$RAW")"
echo "▶ Ham kayit: ${TOTAL}s  (flow exit=$FLOW_RC)"

# İki gecisli palet: duz renkli Flutter UI'da tek gecise gore bariz temiz sonuc.
echo "▶ GIF uretiliyor (${W}px, ${FPS}fps, ${SS}s'den ${DUR}s)…"
ffmpeg -v error -ss "$SS" -t "$DUR" -i "$RAW" \
  -vf "fps=${FPS},scale=${W}:-1:flags=lanczos,palettegen=max_colors=192:stats_mode=diff" \
  -y "$PALETTE"

ffmpeg -v error -ss "$SS" -t "$DUR" -i "$RAW" -i "$PALETTE" \
  -lavfi "fps=${FPS},scale=${W}:-1:flags=lanczos[x];[x][1:v]paletteuse=dither=bayer:bayer_scale=3" \
  -y "$OUT"

rm -f "$PALETTE"
echo "✅ $OUT  ($(du -h "$OUT" | cut -f1))  ham kayit: $RAW"
