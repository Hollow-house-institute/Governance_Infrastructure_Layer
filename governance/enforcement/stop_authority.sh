#!/data/data/com.termux/files/usr/bin/bash

DRIFT_FILE="runtime/drift/drift.json"
ESC_FILE="runtime/escalation/escalation.json"

DRIFT=$(jq -r '.count // 0' "$DRIFT_FILE" 2>/dev/null)
ESC=$(jq -r '.count // 0' "$ESC_FILE" 2>/dev/null)

# fallback if empty
DRIFT=${DRIFT:-0}
ESC=${ESC:-0}

DRIFT_THRESHOLD=5
ESC_THRESHOLD=3

if [ "$DRIFT" -gt "$DRIFT_THRESHOLD" ]; then
  echo "STOP: Drift threshold exceeded"
  exit 1
fi

if [ "$ESC" -gt "$ESC_THRESHOLD" ]; then
  echo "STOP: Escalation threshold exceeded"
  exit 1
fi

echo "OK: Governance within bounds"
