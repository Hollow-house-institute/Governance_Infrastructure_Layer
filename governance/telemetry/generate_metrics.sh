set -e
#!/data/data/com.termux/files/usr/bin/bash

LOG_DIR="runtime/logs"
DRIFT_FILE="runtime/drift/drift.json"
ESC_FILE="runtime/escalation/escalation.json"

failures=$(grep -h "FAIL" $LOG_DIR/*.log 2>/dev/null | wc -l)
drift=$(cat $DRIFT_FILE 2>/dev/null | wc -c)
escalations=$(cat $ESC_FILE 2>/dev/null | wc -c)

failures=${failures:-0}
drift=${drift:-0}
escalations=${escalations:-0}

gsi=$((100 - failures*10 - drift*5 - escalations*5))
aas=$((100 - drift*10))
lss=$((100 - failures*5))

mkdir -p telemetry runtime/logs

echo "timestamp: $(date -u)" > telemetry/metrics.log
echo "failures: $failures" >> telemetry/metrics.log
echo "drift_events: $drift" >> telemetry/metrics.log
echo "escalations: $escalations" >> telemetry/metrics.log
echo "governance_stability_index: $gsi" >> telemetry/metrics.log
echo "authority_alignment_score: $aas" >> telemetry/metrics.log
echo "language_symmetry_score: $lss" >> telemetry/metrics.log
