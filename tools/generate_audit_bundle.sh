#!/data/data/com.termux/files/usr/bin/bash

OUT="audit_bundle_$(date +%s)"
mkdir -p "$OUT"

cp drift.json "$OUT/"
cp escalation.json "$OUT/"
cp audits/logs/events.log "$OUT/" 2>/dev/null

sha256sum "$OUT"/* > "$OUT/CHECKSUMS.sha256"

echo "Audit bundle created: $OUT"
