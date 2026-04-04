# Governance Infrastructure Layer

A real-time system that converts behavioral drift into enforceable control decisions.

This is not monitoring.  
This is control.

---

## Example

**Input**
POST /drift  
{ "count": 3 }

**Output**
{
  "severity_label": "CRITICAL",
  "stop_authority": true
}

When drift crosses a threshold, the system can signal execution to stop.

---

## Quick Start

```bash
npm install
node index.js

## Start Here

See: docs/START_HERE.md

## What this is

This is Execution-Time Governance.

The system detects Behavioral Drift, evaluates Decision Boundary conditions, triggers Escalation, enforces Stop Authority, and restores access only after resolution.

## Quick demo

echo '{"count": 2}' > drift.json
python runtime/enforce.py
curl -i http://localhost:8080

## Expected

HTTP 423

## Why this matters

This system does not describe governance.

It enforces it.

## Core terms

- Behavioral Drift
- Decision Boundary
- Stop Authority
- Escalation
- Interaction Trace
- Governance Telemetry
- Longitudinal Accountability

## Outcome

Governance as Infrastructure.
