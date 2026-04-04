import json, time, uuid

TRACE_FILE = "runtime/interaction_trace.jsonl"
TELEMETRY_FILE = "runtime/governance_telemetry.jsonl"

DECISION_BOUNDARY = {
    "drift_threshold": 0.7,
    "severity_levels": ["low", "medium", "high", "critical"]
}

def log_event(file, data):
    with open(file, "a") as f:
        f.write(json.dumps(data) + "\n")

def detect_behavioral_drift(signal):
    return signal.get("drift_score", 0)

def enforce_stop_authority(severity):
    if severity == "critical":
        raise Exception("STOP AUTHORITY TRIGGERED")

def escalate(event):
    event["escalation"] = True
    event["escalation_persistent"] = True
    return event

def process_event(signal):
    event_id = str(uuid.uuid4())
    drift = detect_behavioral_drift(signal)

    severity = "low"
    if drift > 0.9:
        severity = "critical"
    elif drift > 0.75:
        severity = "high"
    elif drift > 0.5:
        severity = "medium"

    event = {
        "event_id": event_id,
        "timestamp": time.time(),
        "drift_score": drift,
        "severity": severity,
        "accountability": signal.get("actor", "unknown"),
        "trace": signal,
    }

    if drift >= DECISION_BOUNDARY["drift_threshold"]:
        event = escalate(event)
        enforce_stop_authority(severity)

    log_event(TRACE_FILE, event)
    log_event(TELEMETRY_FILE, {
        "event_id": event_id,
        "severity": severity,
        "drift": drift
    })

    return event
