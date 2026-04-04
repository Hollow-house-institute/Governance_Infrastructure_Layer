#!/data/data/com.termux/files/usr/bin/bash
set -e

OUT="governance/timeline/timeline.md"

echo "# HHI Governance Event Timeline" > "$OUT"
echo "Generated: $(date)" >> "$OUT"
echo "" >> "$OUT"

echo "## Drift Events" >> "$OUT"
nl -ba runtime/evidence/drift.log 2>/dev/null || echo "No drift events." >> "$OUT"
echo "" >> "$OUT"

echo "## Escalation Events" >> "$OUT"
nl -ba runtime/evidence/escalation.log 2>/dev/null || echo "No escalation events." >> "$OUT"
echo "" >> "$OUT"

echo "## Assurance Cycles" >> "$OUT"
nl -ba runtime/evidence/assurance.log 2>/dev/null || echo "No assurance cycles." >> "$OUT"

echo "[HHI] Timeline generated at $OUT"
