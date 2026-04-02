# Demo Script

## Step 1 — Show normal system

- Open browser
- Show login page

## Step 2 — Introduce Behavioral Drift

echo '{"count": 2}' > drift.json
python runtime/enforce.py

## Step 3 — Show enforcement

- Refresh browser

Expected:
STOP AUTHORITY ACTIVE

Say:
"The system detected Behavioral Drift, crossed a Decision Boundary, triggered Escalation, and enforced Stop Authority."

## Step 4 — Explain simply

- "This is not monitoring"
- "This is Execution-Time Governance"
- "The system enforces control during execution"

## Step 5 — Resolve

echo '{"count": 0}' > drift.json
python runtime/resolve.py

## Step 6 — Show recovery

- Refresh browser
- Login page returns

Say:
"Access is restored only after the condition is resolved and logged."

## Close

"This system converts governance from policy into enforcement."
