#!/bin/bash
set -euo pipefail

# Builds build/web for Firebase Hosting and refuses to hand over a bundle that
# carries anything it should not. Shared by scripts/deploy_web.sh and
# .github/workflows/deploy_web.yml so local and CI deploys ship the same bytes.

cd "$(dirname "$0")/.."

# App Check on web needs the reCAPTCHA Enterprise site key registered under
# Firebase Console → App Check → Apps → Web. It is public by design (it ships in
# the bundle), which is why it travels as a build argument and not a secret.
# Empty means this build runs without App Check; do not enable enforcement while
# that is the case.
recaptcha_site_key=${RECAPTCHA_ENTERPRISE_SITE_KEY:-}

# The Firebase web apiKey is public by design; every other Google key is not.
allowed_web_api_key=$(
  awk '/static const FirebaseOptions web/,/\);/' lib/firebase_options.dart |
    grep -oE 'AIza[0-9A-Za-z_-]{35}' | head -n 1
)

flutter pub get
dart run build_runner build --delete-conflicting-outputs
dart run easy_localization:generate -O lib/product/init/language -f keys \
  -o locale_keys.g.dart --source-dir assets/translations
flutter build web --release --no-source-maps --no-wasm-dry-run \
  --dart-define=RECAPTCHA_ENTERPRISE_SITE_KEY="$recaptcha_site_key"

out=build/web

# Engine debug symbols are 6 files of noise; never upload them (audit F-17).
# firebase.json also ignores them, but deleting is the guarantee.
find "$out" -name '*.symbols' -delete

# Not fatal: a build without the key still ships, it just cannot answer App Check.
if [ -z "$recaptcha_site_key" ]; then
  echo "web_build: RECAPTCHA_ENTERPRISE_SITE_KEY is empty, App Check is off on web" >&2
# Site keys are ASCII, so the literal survives dart2js string escaping.
elif ! grep -rqF -- "$recaptcha_site_key" "$out"; then
  echo "web_build: site key not found in $out, check App Check in the browser" >&2
fi
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
