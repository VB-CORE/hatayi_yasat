#!/bin/bash
set -euo pipefail

# Local deploy of the Flutter web build to Firebase Hosting (project savehatay).
#
#   scripts/deploy_web.sh                 serve on this machine only, nothing uploaded
#   scripts/deploy_web.sh preview <name>  preview channel: unlisted URL, still public
#   scripts/deploy_web.sh live            production (asks for confirmation)
#
# Options: --skip-build reuses the existing build/web.
# Env:     FIREBASE_ACCOUNT picks the Firebase CLI account (firebase login:list),
#          PREVIEW_EXPIRES sets the preview lifetime (default 1d),
#          LOCAL_PORT sets the local port (default 5050).

cd "$(dirname "$0")/.."

project=savehatay
target=app
mode=local
channel=
skip_build=0

for arg in "$@"; do
  case "$arg" in
    local | preview | live) mode=$arg ;;
    --skip-build) skip_build=1 ;;
    -h | --help)
      sed -n '4,14p' "$0" | sed -E 's/^# ?//'
      exit 0
      ;;
    -*)
      echo "deploy_web: unknown option $arg" >&2
      exit 2
      ;;
    *) channel=$arg ;;
  esac
done

command -v firebase >/dev/null || {
  echo "deploy_web: firebase CLI not found (npm i -g firebase-tools)" >&2
  exit 1
}

firebase_args=(--project "$project")
if [ -n "${FIREBASE_ACCOUNT:-}" ]; then
  firebase_args+=(--account "$FIREBASE_ACCOUNT")
fi

branch=$(git rev-parse --abbrev-ref HEAD)
commit=$(git rev-parse --short HEAD)

if [ "$mode" = live ]; then
  if [ "$branch" != main ]; then
    echo "deploy_web: live deploys go out from main, current branch is $branch" >&2
    exit 1
  fi
  if [ -n "$(git status --porcelain)" ]; then
    echo "deploy_web: working tree is dirty, commit or stash first" >&2
    exit 1
  fi
  git fetch --quiet origin main
  if [ "$(git rev-parse HEAD)" != "$(git rev-parse origin/main)" ]; then
    echo "deploy_web: local main differs from origin/main" >&2
    exit 1
  fi
fi

if [ "$skip_build" -eq 0 ]; then
  # A local Flutter newer than CI's re-pins SDK-bound packages in pubspec.lock.
  # The lock is the authority (CLAUDE.md §8), so a deploy must not rewrite it.
  lock_backup=$(mktemp)
  cp pubspec.lock "$lock_backup"
  trap 'cp "$lock_backup" pubspec.lock; rm -f "$lock_backup"' EXIT
  bash scripts/web_build.sh
elif [ ! -f build/web/index.html ]; then
  echo "deploy_web: --skip-build given but build/web is missing" >&2
  exit 1
fi

if [ "$mode" = local ]; then
  firebase serve --only "hosting:$target" --port "${LOCAL_PORT:-5050}" \
    "${firebase_args[@]}"
elif [ "$mode" = live ]; then
  printf 'Deploy %s to LIVE hosting of %s? Type "live" to continue: ' \
    "$commit" "$project"
  read -r answer
  [ "$answer" = live ] || {
    echo "deploy_web: aborted"
    exit 1
  }
  firebase deploy --only "hosting:$target" "${firebase_args[@]}" \
    --message "local $commit"
else
  if [ -z "$channel" ]; then
    channel=$(echo "$branch" | tr -c 'a-zA-Z0-9\n' '-' | cut -c1-40)
  fi
  firebase hosting:channel:deploy "$channel" --only "$target" \
    --expires "${PREVIEW_EXPIRES:-1d}" "${firebase_args[@]}"
fi
