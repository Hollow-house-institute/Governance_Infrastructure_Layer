#!/data/data/com.termux/files/usr/bin/bash
set -e

case "$1" in
  dashboard)
    bash governance/dashboard/generate_dashboard.sh
    cat governance/dashboard/dashboard.md
    ;;
  drift)
    bash system/drift/drift_runner.sh
    tail -n 20 runtime/evidence/drift.log 2>/dev/null || echo "No drift evidence."
    ;;
  escalation)
    bash system/escalation/escalation_checker.sh
    tail -n 20 runtime/evidence/escalation.log 2>/dev/null || echo "No escalation evidence."
    ;;
  assurance)
    tail -n 40 runtime/evidence/assurance.log 2>/dev/null || echo "No assurance evidence."
    ;;
  health)
    bash governance/health/health_score.sh
    cat governance/health/health_score.json
    ;;
  report)
    bash system/reports/report_generator.sh
    ;;
  enforce-terms)
    bash governance/enforcement/enforce_terms.sh
    ;;
  daemon)
    bash governance/daemon/daemon_supervisor.sh "${2:-status}"
    ;;
  *)
    echo "HHI Governance CLI"
    echo "Usage: $0 {dashboard|drift|escalation|assurance|health|report|enforce-terms|daemon [start|stop|status]}"
    ;;
esac
