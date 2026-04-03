#!/bin/bash
set -e

LOG_DIR="runtime/logs"
DRIFT_FILE="runtime/drift/drift.json"
ESC_FILE="runtime/escalation/escalation.json"

mkdir -p telemetry runtime/logs

ACTOR=$(whoami)
TIME=$(date -u)
echo "actor: $ACTOR | action: telemetry_run | time: $TIME" >> runtime/logs/auth.log

failures=$(grep -h "FAIL" $LOG_DIR/*.log 2>/dev/null | wc -l || echo 0)
drift=$(cat $DRIFT_FILE 2>/dev/null | wc -c || echo 0)
escalations=$(cat $ESC_FILE 2>/dev/null | wc -c || echo 0)

gsi=$((100 - failures*10 - drift*5 - escalations*5))
aas=$((100 - drift*10))
lss=$((100 - failures*5))

if [ "$gsi" -ge 80 ]; then status="STABLE"
elif [ "$gsi" -ge 50 ]; then status="WARNING"
else status="CRITICAL"
fi

echo "timestamp: $TIME" > telemetry/metrics.log
echo "actor: $ACTOR" >> telemetry/metrics.log
echo "failures: $failures" >> telemetry/metrics.log
echo "drift_events: $drift" >> telemetry/metrics.log
echo "escalations: $escalations" >> telemetry/metrics.log
echo "governance_stability_index: $gsi" >> telemetry/metrics.log
echo "authority_alignment_score: $aas" >> telemetry/metrics.log
echo "language_symmetry_score: $lss" >> telemetry/metrics.log
echo "status: $status" >> telemetry/metrics.log
