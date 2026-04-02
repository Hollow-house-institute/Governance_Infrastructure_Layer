#!/data/data/com.termux/files/usr/bin/bash
set -e

echo "[HHI] Running Drift Detection..."

TARGETS=(
  "docs/"
  "runtime/"
  "system/"
)

LOG="runtime/evidence/drift.log"

for t in "${TARGETS[@]}"; do
  if [ ! -d "$t" ]; then
    echo "[DRIFT] Missing expected directory: $t" >> "$LOG"
  fi
done

echo "[HHI] Drift detection complete."
