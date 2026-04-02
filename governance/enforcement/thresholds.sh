#!/data/data/com.termux/files/usr/bin/bash
set -e

METRICS="telemetry/metrics.log"
mkdir -p runtime/logs runtime/escalation

ACTOR=$(whoami)
TIME=$(date -u)
echo "actor: $ACTOR | action: threshold_check | time: $TIME" >> runtime/logs/auth.log

if [ ! -f "$METRICS" ]; then
  echo "GOVERNANCE FAILURE: Missing telemetry" >> runtime/logs/stop.log
  exit 1
fi

failures=$(grep "failures:" $METRICS | awk '{print $2}')
drift=$(grep "drift_events:" $METRICS | awk '{print $2}')

failures=${failures:-0}
drift=${drift:-0}

# Mandatory escalation (non-optional)
if [ "$drift" -gt 0 ]; then
  echo "ESCALATION REQUIRED | actor: $ACTOR | time: $TIME" >> runtime/escalation/escalation.json
  bash governance/enforcement/accountability.sh
fi

# Hard Stop Authority (terminal)
if [ "$failures" -ge 2 ]; then
  echo "STOP AUTHORITY ENFORCED | actor: $ACTOR | time: $TIME" >> runtime/logs/stop.log
  exit 1
fi
