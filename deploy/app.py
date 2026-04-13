from flask import Flask, jsonify, request, send_from_directory, send_file
from flask_cors import CORS
import time, json, os

app = Flask(__name__, static_folder="static")
CORS(app)

drift_state = {"count": 0}
LOG_FILE = "audit_log.jsonl"

def scoring(drift, escalation, stop):
    # Normalize drift (0–3)
    drift_norm = drift / 3.0

    governance_stability = round((1 - drift_norm) * 100, 2)

    authority_alignment = 100
    if escalation:
        authority_alignment -= 30
    if stop:
        authority_alignment -= 50

    escalation_pressure = round(drift_norm * 100, 2)

    longitudinal_risk = round((drift_norm * 0.7 + (1 if stop else 0)*0.3) * 100, 2)

    return {
        "governance_stability_index": governance_stability,
        "authority_alignment_score": authority_alignment,
        "escalation_pressure": escalation_pressure,
        "longitudinal_risk_score": longitudinal_risk
    }

def evaluate(drift):
    if drift == 0:
        level, label = 0, "STABLE"
    elif drift == 1:
        level, label = 1, "LOW"
    elif drift == 2:
        level, label = 2, "MEDIUM"
    else:
        level, label = 3, "CRITICAL"

    escalation = level >= 2
    stop = level >= 3

    scores = scoring(drift, escalation, stop)

    result = {
        "drift": drift,
        "severity_level": level,
        "severity_label": label,
        "decision_boundary": "BREACHED" if escalation else "NORMAL",
        "escalation_active": escalation,
        "stop_authority": stop,
        "accountability_required": escalation,
        "scores": scores,
        "timestamp": time.time()
    }

    with open(LOG_FILE, "a") as f:
        f.write(json.dumps(result) + "\n")

    return result

@app.route("/")
def ui():
    return send_from_directory("static", "index.html")

@app.route("/api")
def api():
    result = evaluate(drift_state["count"])
    if result["stop_authority"]:
        return jsonify(result), 423
    return jsonify(result)

@app.route("/drift", methods=["POST"])
def set_drift():
    data = request.json or {}
    drift_state["count"] = int(data.get("count", 0))
    return {"status": "updated", "drift": drift_state["count"]}

@app.route("/audit")
def audit():
    if not os.path.exists(LOG_FILE):
        return jsonify([])
    with open(LOG_FILE, "r") as f:
        logs = [json.loads(line) for line in f.readlines()]
    return jsonify(logs)
