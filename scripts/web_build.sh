#!/bin/bash
set -euo pipefail

# Builds build/web for Firebase Hosting and refuses to hand over a bundle that
# carries anything it should not. Shared by scripts/deploy_web.sh and
# .github/workflows/deploy_web.yml so local and CI deploys ship the same bytes.

cd "$(dirname "$0")/.."

# The Firebase web apiKey is public by design; every other Google key is not.
allowed_web_api_key=$(
  awk '/static const FirebaseOptions web/,/\);/' lib/firebase_options.dart |
    grep -oE 'AIza[0-9A-Za-z_-]{35}' | head -n 1
)

flutter pub get
dart run build_runner build --delete-conflicting-outputs
dart run easy_localization:generate -O lib/product/init/language -f keys \
  -o locale_keys.g.dart --source-dir assets/translations
flutter build web --release --no-source-maps --no-wasm-dry-run

out=build/web
failed=0

fail() {
  echo "web_build: $1" >&2
  failed=1
}

leaked_files=$(find "$out" \( -name '*.map' -o -name '.env*' -o -name '*.pem' \
  -o -name '*.p12' -o -name '*.jks' -o -name 'service_account*.json' \
  -o -name 'google-services.json' \) -print)
[ -z "$leaked_files" ] || fail "files that must not be public:
$leaked_files"

leaked_secrets=$(grep -rlIE \
  -e '-----BEGIN [A-Z ]*PRIVATE KEY' \
  -e '"type": *"service_account"' \
  -e 'mongodb(\+srv)?://' \
  "$out" || true)
[ -z "$leaked_secrets" ] || fail "secret pattern found in:
$leaked_secrets"

foreign_keys=$(grep -rhoIE 'AIza[0-9A-Za-z_-]{35}' "$out" |
  sort -u | grep -vxF "$allowed_web_api_key" || true)
[ -z "$foreign_keys" ] || fail "Google API key other than the Firebase web key:
$(echo "$foreign_keys" | sed -E 's/^(.{10}).*(.{4})$/\1...\2/')"

[ "$failed" -eq 0 ] || exit 1
echo "web_build: $out is clean ($(du -sh "$out" | cut -f1))"
