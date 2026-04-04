#!/data/data/com.termux/files/usr/bin/bash
set -e

OUT="governance/evidence/normalized_evidence.json"

DRIFT=$(sed 's/"/\\"/g' runtime/evidence/drift.log 2>/dev/null || echo "")
ESC=$(sed 's/"/\\"/g' runtime/evidence/escalation.log 2>/dev/null || echo "")
ASSURANCE=$(sed 's/"/\\"/g' runtime/evidence/assurance.log 2>/dev/null || echo "")

cat << JSON > "$OUT"
{
  "timestamp": "$(date)",
  "drift": "$DRIFT",
  "escalation": "$ESC",
  "assurance": "$ASSURANCE"
}
JSON

echo "[HHI] Evidence normalized to $OUT"
