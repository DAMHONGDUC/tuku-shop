#!/usr/bin/env bash
# Downloads every photo in tool/mock_images.csv into assets/, resized for the
# app (800 px long edge, JPEG q75). Existing files are skipped, so the script
# is safe to re-run after adding rows.
#
# CSV columns: asset_path,source_url,photographer,license
set -euo pipefail

cd "$(dirname "$0")/.."
manifest="tool/mock_images.csv"

tail -n +2 "$manifest" | while IFS=, read -r asset url author license; do
  [[ -z "$asset" ]] && continue
  if [[ -f "$asset" ]]; then continue; fi
  mkdir -p "$(dirname "$asset")"
  echo "↓ $asset"
  curl -fsSL "${url}?w=800&q=75&fm=jpg&fit=max" -o "$asset"
done

echo "Done: $(tail -n +2 "$manifest" | wc -l | tr -d ' ') images in manifest."
