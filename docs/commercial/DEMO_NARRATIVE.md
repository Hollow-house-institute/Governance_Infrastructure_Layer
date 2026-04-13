# Demo Narrative

## Opening

What you are seeing is not a dashboard.

It is a control system.

---

## Step 1 — Introduce drift

We simulate Behavioral Drift:

echo '{"count": 3}' > drift.json

---

## Step 2 — Run enforcement

python runtime/enforce.py

The system evaluates Decision Boundary conditions.

---

## Step 3 — Show escalation

cat escalation.json

Escalation is active because Intervention Threshold was crossed.

This is not optional.

---

## Step 4 — Show Stop Authority

test -f STOP

At critical severity, execution is halted.

The system enforces Stop Authority.

---

## Step 5 — Explain control

Execution cannot continue until:

- the issue is resolved  
- an accountable actor is recorded  
- the state is validated  

---

## What this proves

- Behavioral Drift is detected  
- Decision Boundary is enforced  
- Escalation is automatic  
- Stop Authority is real  
- Accountability is required  

---

## Why this matters

Without this system:

- escalation is ignored  
- execution continues  
- risk accumulates  
- failure repeats  

With this system:

- execution is controlled  
- risk is contained  
- evidence is preserved  

---

## Close

This is Governance as Infrastructure.

It does not describe control.

It enforces it.
