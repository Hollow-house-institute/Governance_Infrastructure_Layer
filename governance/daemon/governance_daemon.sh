#!/data/data/com.termux/files/usr/bin/bash
set -e

LOG="runtime/evidence/assurance.log"

echo "[HHI] Continuous Governance Daemon starting..."

while true; do
  echo "" >> "$LOG"
  echo "=== Assurance Cycle: $(date) ===" >> "$LOG"

  # Drift check
  bash system/drift/drift_runner.sh

  # Escalation check
  bash system/escalation/escalation_checker.sh

  # Metadata update
  bash system/metadata/metadata_stamper.sh

  # Dashboard refresh
  bash governance/dashboard/generate_dashboard.sh

  # Health score update
  bash governance/health/health_score.sh

  echo "[HHI] Assurance cycle complete." >> "$LOG"

  sleep 1800   # 30 minutes
done
