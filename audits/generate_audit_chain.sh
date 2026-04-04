#!/data/data/com.termux/files/usr/bin/bash

OUT="audits/manifests/manifest_$(date +%s).txt"

echo "timestamp=$(date -Iseconds)" > "$OUT"
find runtime -type f >> "$OUT"

sha256sum "$OUT" > "$OUT.sha256"

# correct latest pointer
ls -t audits/manifests | head -n 1 > audits/latest.txt

echo "Audit chain generated: $OUT"
