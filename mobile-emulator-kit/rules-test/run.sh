#!/usr/bin/env bash
#
# Firestore guvenlik kurallarini izole bir emulator'de test eder. Calisan
# emulator suite'ine dokunmaz (kendi portunu acar, sonunda kapatir).
#
#   cd mobile-emulator-kit/rules-test && npm install && ./run.sh

set -euo pipefail

cd "$(dirname "$0")"

# jenv shim'i bozuk oldugunda firebase CLI java'yi bulamiyor; kitin
# start-emulator.sh dosyasindaki fallback'in aynisi.
if ! java -version >/dev/null 2>&1; then
  for candidate in \
    "$(/usr/libexec/java_home -v 21 2>/dev/null || true)" \
    "/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home" \
    "$(/usr/libexec/java_home 2>/dev/null || true)"; do
    if [ -n "$candidate" ] && [ -x "$candidate/bin/java" ]; then
      export JAVA_HOME="$candidate"
      export PATH="$JAVA_HOME/bin:$PATH"
      break
    fi
  done
fi

# Test edilen kurallar her zaman kitin guncel kopyasi.
cp ../firebase/firestore.rules ./firestore.rules

exec firebase emulators:exec --only firestore --project savehatay \
  "node merchant_rules_test.mjs"
