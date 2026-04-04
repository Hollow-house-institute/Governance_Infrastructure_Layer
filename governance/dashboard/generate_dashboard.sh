#!/data/data/com.termux/files/usr/bin/bash
set -e

DASH="governance/dashboard/dashboard.md"

echo "# HHI Governance Telemetry Dashboard" > "$DASH"
echo "Generated: $(date)" >> "$DASH"
echo "" >> "$DASH"

echo "## Drift Evidence Summary" >> "$DASH"
tail -n 20 runtime/evidence/drift.log 2>/dev/null || echo "No drift evidence." >> "$DASH"
echo "" >> "$DASH"

echo "## Escalation Integrity Summary" >> "$DASH"
tail -n 20 runtime/evidence/escalation.log 2>/dev/null || echo "No escalation evidence." >> "$DASH"
echo "" >> "$DASH"

echo "## Assurance Cycle Summary" >> "$DASH"
tail -n 20 runtime/evidence/assurance.log 2>/dev/null || echo "No assurance evidence." >> "$DASH"
echo "" >> "$DASH"

echo "## Metadata Freshness" >> "$DASH"
jq '.' runtime/metadata.json >> "$DASH" 2>/dev/null || echo "Metadata missing." >> "$DASH"

echo "" >> "$DASH"
echo "## Governance Health Score" >> "$DASH"
echo "Score calculation coming soon (HHI-GOV-02)." >> "$DASH"

echo "[HHI] Dashboard generated at $DASH"
