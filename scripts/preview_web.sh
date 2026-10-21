#!/bin/bash
set -euo pipefail

# One-command preview deploy: builds the web bundle with the App Check site key
# and publishes the current branch to a Firebase Hosting preview channel.
#
#   scripts/preview_web.sh               build + deploy (7 day channel)
#   scripts/preview_web.sh --skip-build  reuse the existing build/web
#
# The site key is public by design (it ships in the bundle), so it lives here as
# a default; override it with RECAPTCHA_ENTERPRISE_SITE_KEY when it rotates.
# Env: FIREBASE_ACCOUNT (pick your own with `firebase login:use`), PREVIEW_EXPIRES
# (default 7d).

cd "$(dirname "$0")/.."

for arg in "$@"; do
  case "$arg" in
    -h | --help)
      sed -n '4,12p' "$0" | sed -E 's/^# ?//'
      exit 0
      ;;
  esac
done

site_key=${RECAPTCHA_ENTERPRISE_SITE_KEY:-6Le5fvotAAAAAA65sErpFR_xqulLnCb-U2fD0cFE}

RECAPTCHA_ENTERPRISE_SITE_KEY=$site_key \
  PREVIEW_EXPIRES=${PREVIEW_EXPIRES:-7d} \
  bash scripts/deploy_web.sh preview "$@"
