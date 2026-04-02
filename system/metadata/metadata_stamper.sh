#!/data/data/com.termux/files/usr/bin/bash
set -e

STAMP_FILE="runtime/metadata.json"

echo "[HHI] Updating metadata timestamp..."

jq '.last_updated = now' "$STAMP_FILE" > "$STAMP_FILE.tmp"
mv "$STAMP_FILE.tmp" "$STAMP_FILE"

echo "[HHI] Metadata updated."
