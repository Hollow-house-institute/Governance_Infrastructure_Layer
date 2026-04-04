#!/data/data/com.termux/files/usr/bin/bash
set -e

echo "[HHI] Streaming governance telemetry as JSON. Ctrl+C to stop."

while true; do
  DRIFT_COUNT=$(wc -l < runtime/evidence/drift.log 2>/dev/null || echo 0)
  ESC_COUNT=$(wc -l < runtime/evidence/escalation.log 2>/dev/null || echo 0)
  ASSURANCE_COUNT=$(wc -l < runtime/evidence/assurance.log 2>/dev/null || echo 0)

  if [ -f governance/health/health_score.json ]; then
    HEALTH_JSON=$(cat governance/health/health_score.json)
  else
    HEALTH_JSON="{}"
  fi

  cat << JSON
{
  "timestamp": "$(date +%Y-%m-%dT%H:%M:%S)",
  "drift_events": "$DRIFT_COUNT",
  "escalation_events": "$ESC_COUNT",
  "assurance_cycles": "$ASSURANCE_COUNT",
  "health": $HEALTH_JSON
}
JSON

  sleep 10
done
