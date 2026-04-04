#!/data/data/com.termux/files/usr/bin/bash
set -e

echo "[HHI] Starting Continuous Assurance Daemon..."

while true; do
  date >> runtime/evidence/assurance.log
  echo "[ASSURANCE] Running drift + escalation checks..." >> runtime/evidence/assurance.log

  bash system/drift/drift_runner.sh
  bash system/escalation/escalation_checker.sh

  sleep 3600
done
