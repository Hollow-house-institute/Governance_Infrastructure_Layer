#!/data/data/com.termux/files/usr/bin/bash
set -e

CANONICAL=("governance" "telemetry" "assurance" "escalation" "drift" "canonical" "authority" "HHI")
LOG="runtime/evidence/drift.log"

echo "[HHI] Running canonical term enforcement..."

for file in \$(git ls-files); do
  for term in "\${CANONICAL[@]}"; do
    if ! grep -qi "\$term" "\$file"; then
      echo "[TERM] Missing canonical term '\$term' in \$file" >> "\$LOG"
    fi
  done
done

echo "[HHI] Canonical term enforcement complete."
