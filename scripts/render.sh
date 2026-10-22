#!/usr/bin/env bash
set -euo pipefail

: "${GITHUB_WORKSPACE:?GITHUB_WORKSPACE is required}"
: "${DOCS_PATH:?DOCS_PATH is required}"
: "${OUTPUT_PATH:?OUTPUT_PATH is required}"

MDU_VERSION="${MDU_VERSION:-5.1.0}"
args=(render "$DOCS_PATH" "$OUTPUT_PATH")

if [[ -n "${EDIT_PAGE_ROOT:-}" ]]; then
  args+=(--editPageRoot "$EDIT_PAGE_ROOT")
fi

docker run --rm \
  --volume "$GITHUB_WORKSPACE:$GITHUB_WORKSPACE" \
  --workdir "$GITHUB_WORKSPACE" \
  --user "$(id -u):$(id -g)" \
  "capjan/mdu:$MDU_VERSION" \
  "${args[@]}"
