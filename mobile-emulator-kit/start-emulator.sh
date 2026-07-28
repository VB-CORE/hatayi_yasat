#!/usr/bin/env bash
#
# Start the local Firebase emulator suite (Auth + Firestore + Storage + UI)
# seeded with sample data, for mobile app development against a fake backend.
# No real Firebase project access or login is required.
#
# Ports (must match the app's emulator config):
#   Auth 3000 · Firestore 3004 · Storage 3005 · UI 3002
#
# Usage:
#   ./start-emulator.sh

set -euo pipefail

cd "$(dirname "$0")"

# The emulator needs a working JDK. If `java` is missing/broken on PATH,
# fall back to a Homebrew/system JDK (prefer LTS 21).
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
echo "Using Java: $(java -version 2>&1 | head -1)"

PROJECT_ID="savehatay"
# Immutable sample dataset shipped in this kit. Never written to.
BASELINE_DIR="seed-data"
# Local session state (created on first run). Resuming from here keeps any
# users/data you create in the emulator across restarts.
LOCAL_DIR="emulator-data"

# Resume from local session state if it exists, otherwise seed from the baseline.
if [ -d "$LOCAL_DIR" ]; then
  IMPORT_DIR="$LOCAL_DIR"
  echo "Resuming local session data from '$LOCAL_DIR'…"
elif [ -d "$BASELINE_DIR" ]; then
  IMPORT_DIR="$BASELINE_DIR"
  echo "First run: importing sample dataset from '$BASELINE_DIR'…"
else
  IMPORT_DIR=""
  echo "No data to import — starting empty." >&2
fi

# `exec` so Ctrl+C reaches firebase directly and export-on-exit fires cleanly.
if [ -n "$IMPORT_DIR" ]; then
  exec firebase emulators:start --only "auth,firestore,storage" \
    --project "$PROJECT_ID" \
    --import="$IMPORT_DIR" \
    --export-on-exit="$LOCAL_DIR"
else
  exec firebase emulators:start --only "auth,firestore,storage" \
    --project "$PROJECT_ID" --export-on-exit="$LOCAL_DIR"
fi
