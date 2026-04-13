# OPERATOR QUICKSTART

## Step 1 — Provide runtime signal

echo '{"count": 3}' > drift.json

## Step 2 — Execute enforcement

python runtime/enforce.py

## Step 3 — Evaluate Decision Boundary

cat escalation.json

## Step 4 — Check Stop Authority

test -f STOP && echo "STOP AUTHORITY ACTIVE"

## Step 5 — Record Accountability

Operator must log:
- actor
- decision
- resolution
- timestamp

## Step 6 — Restore execution

Remove STOP only after:
- root cause resolved
- Accountability bound
- state validated

## Control Rule

Escalation is non-optional.
Stop Authority cannot be bypassed.
