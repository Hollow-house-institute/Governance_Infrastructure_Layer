#!/data/data/com.termux/files/usr/bin/bash
set -e

OUT="governance/visualizer/telemetry_view.md"

echo "# HHI Governance Telemetry View" > "$OUT"
echo "Generated: $(date)" >> "$OUT"
echo "" >> "$OUT"

echo "## Drift (last 20 lines)" >> "$OUT"
tail -n 20 runtime/evidence/drift.log 2>/dev/null || echo "No drift evidence." >> "$OUT"
echo "" >> "$OUT"

echo "## Escalation (last 20 lines)" >> "$OUT"
tail -n 20 runtime/evidence/escalation.log 2>/dev/null || echo "No escalation evidence." >> "$OUT"
echo "" >> "$OUT"

echo "## Assurance (last 20 lines)" >> "$OUT"
tail -n 20 runtime/evidence/assurance.log 2>/dev/null || echo "No assurance evidence." >> "$OUT"
echo "" >> "$OUT"

if [ -f governance/health/health_score.json ]; then
  echo "## Health Score" >> "$OUT"
  cat governance/health/health_score.json >> "$OUT"
else
  echo "## Health Score" >> "$OUT"
  echo "No health score available." >> "$OUT"
fi

echo "[HHI] Telemetry view generated at $OUT"
