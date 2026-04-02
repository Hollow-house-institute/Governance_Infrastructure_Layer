# Governance Infrastructure Layer

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
