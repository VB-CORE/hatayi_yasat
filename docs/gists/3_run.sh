#!/usr/bin/env bash
# life_client — Maestro koşum scripti (iOS simulator)
#
#   ./maestro/run.sh                     # smoke_test_auto — TÜM akışlar tek runda
#   ./maestro/run.sh --build             # önce build + install, sonra auto
#   ./maestro/run.sh smoke               # smoke/ klasöründeki flow'ları tek tek
#   ./maestro/run.sh regression          # regression suite
#   ./maestro/run.sh flows/smoke/x.yaml  # tek flow
#   ./maestro/run.sh --build --device <UDID> auto
#
# --build yoksa mevcut kurulu binary kullanılır. lib/ altında Semantics id
# eklendiyse --build ZORUNLUDUR; yeni id'ler ancak yeni build'de görünür.

set -euo pipefail

MAESTRO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$MAESTRO_DIR/.." && pwd)"
APP_ID="com.hatayiyasat.app"
APP_PATH="$PROJECT_DIR/build/ios/iphonesimulator/Runner.app"
REPORTS_DIR="$MAESTRO_DIR/reports"

RED=$'\033[0;31m'; GREEN=$'\033[0;32m'; YELLOW=$'\033[1;33m'; BLUE=$'\033[0;34m'; NC=$'\033[0m'
info()  { printf '%s\n' "${BLUE}ℹ️  $1${NC}"; }
ok()    { printf '%s\n' "${GREEN}✅ $1${NC}"; }
warn()  { printf '%s\n' "${YELLOW}⚠️  $1${NC}"; }
fail()  { printf '%s\n' "${RED}❌ $1${NC}" >&2; }

DO_BUILD=0
DEVICE_ID=""
TARGET="auto"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --build)  DO_BUILD=1; shift ;;
    --device) DEVICE_ID="${2:-}"; shift 2 ;;
    -h|--help) sed -n '2,11p' "${BASH_SOURCE[0]}"; exit 0 ;;
    *) TARGET="$1"; shift ;;
  esac
done

command -v maestro >/dev/null 2>&1 || { fail "maestro bulunamadı: curl -Ls 'https://get.maestro.mobile.dev' | bash"; exit 1; }
command -v xcrun   >/dev/null 2>&1 || { fail "xcrun bulunamadı — Xcode command line tools gerekli"; exit 1; }

# --- simulator ---------------------------------------------------------------
if [[ -z "$DEVICE_ID" ]]; then
  DEVICE_ID="$(xcrun simctl list devices booted -j \
    | python3 -c 'import json,sys; d=json.load(sys.stdin)["devices"]; print(next((x["udid"] for v in d.values() for x in v if x.get("state")=="Booted"), ""))')"
fi

if [[ -z "$DEVICE_ID" ]]; then
  warn "Booted simulator yok, açılıyor…"
  DEVICE_ID="$(xcrun simctl list devices available -j \
    | python3 -c 'import json,sys; d=json.load(sys.stdin)["devices"]; print(next((x["udid"] for k,v in sorted(d.items(),reverse=True) for x in v if "iPhone" in x.get("name","")), ""))')"
  [[ -n "$DEVICE_ID" ]] || { fail "Kullanılabilir iPhone simulator bulunamadı"; exit 1; }
  xcrun simctl boot "$DEVICE_ID"
  open -a Simulator
  sleep 5
fi
info "Cihaz: $DEVICE_ID"

# --- build + install ---------------------------------------------------------
if [[ "$DO_BUILD" -eq 1 ]]; then
  command -v flutter >/dev/null 2>&1 || { fail "flutter bulunamadı"; exit 1; }
  info "Build (flutter build ios --simulator --debug)… birkaç dakika sürebilir"
  ( cd "$PROJECT_DIR" && flutter build ios --simulator --debug )
  ok "Build tamam"
fi

if [[ -d "$APP_PATH" ]]; then
  info "Kurulum: $APP_PATH"
  xcrun simctl install "$DEVICE_ID" "$APP_PATH"
  ok "Uygulama kuruldu"
else
  warn "Build çıktısı yok ($APP_PATH) — kurulu binary ile devam ediliyor. Güncel değilse: --build"
fi

# --- hedef flow(lar) ---------------------------------------------------------
case "$TARGET" in
  auto)       FLOW_ARG="$MAESTRO_DIR/flows/smoke_test_auto.yaml" ;;
  smoke)      FLOW_ARG="$MAESTRO_DIR/flows/smoke" ;;
  regression) FLOW_ARG="$MAESTRO_DIR/flows/regression" ;;
  core)       FLOW_ARG="$MAESTRO_DIR/flows/core" ;;
  *)
    if [[ -e "$TARGET" ]]; then FLOW_ARG="$TARGET"
    elif [[ -e "$MAESTRO_DIR/$TARGET" ]]; then FLOW_ARG="$MAESTRO_DIR/$TARGET"
    else fail "Hedef bulunamadı: $TARGET"; exit 1; fi ;;
esac

if [[ -d "$FLOW_ARG" ]] && [[ -z "$(find "$FLOW_ARG" -name '*.yaml' -print -quit)" ]]; then
  fail "$FLOW_ARG içinde flow yok. Suite'i kurmak için: Claude Code'da /hata-maestro-auto"
  exit 1
fi

mkdir -p "$REPORTS_DIR/errors" "$REPORTS_DIR/smoke"
STAMP="$(date +%Y%m%d_%H%M%S)"
info "Koşuluyor: $FLOW_ARG"

# takeScreenshot yolları PROJE KÖKÜNE göre çözülür ("maestro/reports/smoke/…"),
# bu yüzden maestro daima proje kökünden çağrılır.
cd "$PROJECT_DIR"

if MAESTRO_DEVICE_ID="$DEVICE_ID" maestro --device "$DEVICE_ID" test "$FLOW_ARG" \
     --format junit --output "$REPORTS_DIR/${TARGET//\//_}_${STAMP}.xml"; then
  ok "Geçti — rapor: $REPORTS_DIR/${TARGET//\//_}_${STAMP}.xml"
else
  fail "Patladı — rapor: $REPORTS_DIR/${TARGET//\//_}_${STAMP}.xml"
  exit 1
fi
