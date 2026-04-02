#!/data/data/com.termux/files/usr/bin/bash
set -e

REPORT="runtime/reports/governance_report_$(date +%Y%m%d_%H%M%S).txt"

echo "[HHI] Generating Governance Integrity Report..." > "$REPORT"

echo "=== HHI Governance Integrity Report ===" >> "$REPORT"
echo "Generated: $(date)" >> "$REPORT"
echo "" >> "$REPORT"

echo "--- Drift Evidence ---" >> "$REPORT"
cat runtime/evidence/drift.log >> "$REPORT" 2>/dev/null || echo "No drift evidence." >> "$REPORT"

echo "" >> "$REPORT"
echo "--- Escalation Evidence ---" >> "$REPORT"
cat runtime/evidence/escalation.log >> "$REPORT" 2>/dev/null || echo "No escalation evidence." >> "$REPORT"

echo "" >> "$REPORT"
echo "--- Assurance Evidence ---" >> "$REPORT"
cat runtime/evidence/assurance.log >> "$REPORT" 2>/dev/null || echo "No assurance evidence." >> "$REPORT"

echo "[HHI] Governance report generated at: $REPORT"
