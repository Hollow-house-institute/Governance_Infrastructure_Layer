#!/data/data/com.termux/files/usr/bin/bash
set -e

echo "[HHI] Running Repo Integrity Guardian..."

REQUIRED_DIRS=(
  "runtime"
  "system"
  "governance"
)

for d in "\${REQUIRED_DIRS[@]}"; do
  if [ ! -d "\$d" ]; then
    echo "[GUARD] ERROR: Missing required directory: \$d"
    exit 1
  fi
done

echo "[HHI] Repo Integrity Guardian passed."
