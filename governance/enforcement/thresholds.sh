set -e
#!/data/data/com.termux/files/usr/bin/bash

METRICS="telemetry/metrics.log"

if [ ! -f "$METRICS" ]; then
  echo "GOVERNANCE FAILURE: Missing telemetry" >> runtime/logs/stop.log
  exit 1
fi

failures=$(grep "failures:" $METRICS | awk '{print $2}')
drift=$(grep "drift_events:" $METRICS | awk '{print $2}')

failures=${failures:-0}
drift=${drift:-0}

if [ "$drift" -gt 0 ]; then
  echo "ESCALATE: Drift detected" >> runtime/escalation/escalation.json
fi

if [ "$failures" -ge 2 ]; then
  echo "STOP AUTHORITY TRIGGERED" >> runtime/logs/stop.log
  bash governance/enforcement/stop_authority.sh
fi
