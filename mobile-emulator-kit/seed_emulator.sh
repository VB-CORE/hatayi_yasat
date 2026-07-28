#!/usr/bin/env bash
#
# Seed the LOCAL Firestore emulator with the minimum data needed to log in and
# exercise the new admin features. Safe to re-run (idempotent PATCH upserts).
#
# Prerequisite: the emulator must already be running (./scripts/emulator.sh).
# This ONLY writes to the emulator (localhost) — production is never touched.
#
# Usage:
#   ./scripts/seed_emulator.sh [admin_email]
# Defaults to vb10learn@gmail.com. Sign in with this Google account in the
# Auth emulator to pass the admin check (adminList/config.emails).

set -euo pipefail

PROJECT_ID="savehatay"
HOST="localhost"
PORT="3004"
ADMIN_EMAIL="${1:-vb10learn@gmail.com}"
BASE="http://${HOST}:${PORT}/v1/projects/${PROJECT_ID}/databases/(default)/documents"

if ! curl -s -o /dev/null "http://${HOST}:${PORT}/"; then
  echo "Firestore emulator not reachable on ${HOST}:${PORT}." >&2
  echo "Start it first: ./scripts/emulator.sh" >&2
  exit 1
fi

# The Firestore emulator enforces security rules even over REST. The special
# "owner" bearer token bypasses rules (equivalent to the Admin SDK), which is
# what a seed script needs.
AUTH_HEADER="Authorization: Bearer owner"

echo "Seeding adminList/config with admin email: ${ADMIN_EMAIL}"
curl -s -X PATCH \
  "${BASE}/adminList/config?updateMask.fieldPaths=emails" \
  -H "${AUTH_HEADER}" \
  -H "Content-Type: application/json" \
  -d "{\"fields\":{\"emails\":{\"arrayValue\":{\"values\":[{\"stringValue\":\"${ADMIN_EMAIL}\"}]}}}}" \
  > /dev/null
echo "  ✓ adminList/config"

# Sample users for the upcoming user-management / permissions screens.
# roleType is numeric: 1 = admin, 2 = user.
seed_user() {
  local uid="$1" email="$2" role="$3" perms_json="$4"
  curl -s -X PATCH "${BASE}/users/${uid}" \
    -H "${AUTH_HEADER}" \
    -H "Content-Type: application/json" \
    -d "{\"fields\":{
          \"uid\":{\"stringValue\":\"${uid}\"},
          \"email\":{\"stringValue\":\"${email}\"},
          \"roleType\":{\"integerValue\":\"${role}\"},
          \"permissions\":{\"arrayValue\":{\"values\":${perms_json}}}
        }}" > /dev/null
  echo "  ✓ users/${uid} (${email}, roleType=${role})"
}

echo "Seeding sample users…"
seed_user "sample_admin" "${ADMIN_EMAIL}" 1 '[]'
seed_user "sample_user_1" "ayse@example.com" 2 '[{"integerValue":"1"}]'
seed_user "sample_user_2" "mehmet@example.com" 2 '[{"integerValue":"2"}]'
seed_user "sample_user_3" "veli@example.com" 2 '[{"integerValue":"1"},{"integerValue":"2"}]'

# --- Community groups ------------------------------------------------------
# Two ready-made groups so the mobile group list, detail tabs and join flow have
# something to render. They reuse the groupCategories already in the export —
# categoryValue is what the list query filters on, so it must stay unique.
# memberCount is seeded consistently with the membership documents, exactly as
# the app's batch writes maintain it.

seed_group() {
  local id="$1" name="$2" description="$3" category_name="$4" category_value="$5" \
        creator="$6" member_count="$7"
  curl -s -X PATCH "${BASE}/groups/${id}" \
    -H "${AUTH_HEADER}" -H "Content-Type: application/json" \
    -d "{\"fields\":{
          \"creatorUid\":{\"stringValue\":\"${creator}\"},
          \"name\":{\"stringValue\":\"${name}\"},
          \"description\":{\"stringValue\":\"${description}\"},
          \"categoryName\":{\"stringValue\":\"${category_name}\"},
          \"categoryValue\":{\"integerValue\":\"${category_value}\"},
          \"isClosed\":{\"booleanValue\":false},
          \"memberCount\":{\"integerValue\":\"${member_count}\"},
          \"isDeleted\":{\"booleanValue\":false},
          \"createdAt\":{\"timestampValue\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\"}
        }}" > /dev/null
  echo "  ✓ groups/${id} (${name})"
}

seed_group_member() {
  local group="$1" uid="$2" display_name="$3" role="$4"
  curl -s -X PATCH "${BASE}/groups/${group}/members/${uid}" \
    -H "${AUTH_HEADER}" -H "Content-Type: application/json" \
    -d "{\"fields\":{
          \"displayName\":{\"stringValue\":\"${display_name}\"},
          \"role\":{\"stringValue\":\"${role}\"},
          \"isDeleted\":{\"booleanValue\":false},
          \"createdAt\":{\"timestampValue\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\"}
        }}" > /dev/null
  echo "  ✓ groups/${group}/members/${uid} (${role})"
}

seed_group_post() {
  local group="$1" id="$2" uid="$3" display_name="$4" content="$5"
  curl -s -X PATCH "${BASE}/groups/${group}/posts/${id}" \
    -H "${AUTH_HEADER}" -H "Content-Type: application/json" \
    -d "{\"fields\":{
          \"author\":{\"mapValue\":{\"fields\":{
            \"uid\":{\"stringValue\":\"${uid}\"},
            \"displayName\":{\"stringValue\":\"${display_name}\"},
            \"role\":{\"stringValue\":\"admin\"}
          }}},
          \"content\":{\"stringValue\":\"${content}\"},
          \"likeCount\":{\"integerValue\":\"0\"},
          \"createdAt\":{\"timestampValue\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\"}
        }}" > /dev/null
  echo "  ✓ groups/${group}/posts/${id}"
}

echo "Seeding sample groups…"
seed_group "sample_group_1" "Hatay Yardımlaşma" \
  "Şehirdeki ihtiyaç ve destek çağrılarının paylaşıldığı grup." \
  "yardımlaşma" 5 "sample_user_1" 2
seed_group_member "sample_group_1" "sample_user_1" "Ayşe Yılmaz" "admin"
seed_group_member "sample_group_1" "sample_user_2" "Mehmet Demir" "member"
seed_group_post "sample_group_1" "sample_post_1" "sample_user_1" "Ayşe Yılmaz" \
  "Gruba hoş geldiniz. İhtiyaç çağrılarını buradan paylaşabilirsiniz."

seed_group "sample_group_2" "Hafta Sonu Etkinlikleri" \
  "Buluşma noktaları ve etkinlik duyuruları." \
  "etkinlik" 4 "sample_user_3" 1
seed_group_member "sample_group_2" "sample_user_3" "Veli Kaya" "admin"

echo "Done. Data persists to the export dir when you stop the emulator (Ctrl+C)."
