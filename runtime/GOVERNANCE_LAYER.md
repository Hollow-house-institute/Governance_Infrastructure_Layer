# Governance Infrastructure Layer — Execution Runtime

## Behavioral Drift
Detected via drift_score per event.

## Continuous Assurance
All events processed in real time via process_event().

## Longitudinal Accountability
Each event includes:
- event_id
- actor (accountability binding)
- timestamp
- trace

## Escalation (Non-Optional)
Triggered automatically when drift >= threshold.
Escalation is persistent and cannot be bypassed.

## Decision Boundary
Defined in DECISION_BOUNDARY config:
- drift_threshold = 0.7

## Stop Authority
Triggered when severity = critical.

## Interaction Trace
Stored in:
runtime/interaction_trace.jsonl

## Governance Telemetry
Stored in:
runtime/governance_telemetry.jsonl
