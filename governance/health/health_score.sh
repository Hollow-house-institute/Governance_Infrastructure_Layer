#!/data/data/com.termux/files/usr/bin/bash
set -e

SCORE_FILE="governance/health/health_score.json"

DRIFT_COUNT=$(wc -l < runtime/evidence/drift.log 2>/dev/null || echo 0)
ESC_COUNT=$(wc -l < runtime/evidence/escalation.log 2>/dev/null || echo 0)
ASSURANCE_COUNT=$(wc -l < runtime/evidence/assurance.log 2>/dev/null || echo 0)

# Simple scoring model (HHI-GOV-02 draft)
SCORE=$((100 - DRIFT_COUNT - ESC_COUNT))

if [ "$SCORE" -lt 0 ]; then
  SCORE=0
fi

cat << JSON > "$SCORE_FILE"
{
  "timestamp": "$(date)",
  "drift_events": "$DRIFT_COUNT",
  "escalation_events": "$ESC_COUNT",
  "assurance_cycles": "$ASSURANCE_COUNT",
  "governance_health_score": "$SCORE"
}
JSON

echo "[HHI] Governance health score updated."
