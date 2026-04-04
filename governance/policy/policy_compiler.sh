#!/data/data/com.termux/files/usr/bin/bash
set -e

POLICY_DIR="governance/policy/rules"
OUT="governance/policy/compiled_checks.sh"

mkdir -p "$POLICY_DIR"

echo "#!/data/data/com.termux/files/usr/bin/bash" > "$OUT"
echo "set -e" >> "$OUT"
echo "" >> "$OUT"
echo "echo \"[HHI] Running compiled governance checks...\"" >> "$OUT"

for rule in "$POLICY_DIR"/*.rule; do
  [ -e "$rule" ] || continue
  NAME=$(basename "$rule")
  echo "echo \"[RULE] Evaluating $NAME\"" >> "$OUT"
  cat "$rule" >> "$OUT"
  echo "" >> "$OUT"
done

chmod +x "$OUT"

echo "[HHI] Policy compiler complete. Compiled checks at $OUT"
