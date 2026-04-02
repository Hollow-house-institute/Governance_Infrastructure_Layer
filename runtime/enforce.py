import json, time, os
from severity import get_severity

ESC="escalation.json"
STOP="STOP"

def run():
    sev = get_severity()

    esc = {
        "active": False,
        "level": sev["level"],
        "label": sev["label"],
        "ts": time.time()
    }

    # Decision Boundary via Intervention Threshold
    if sev["level"] >= 2:
        esc["active"] = True

        # Stop Authority only at CRITICAL
        if sev["level"] >= 3:
            open(STOP, "w").write("HALT")

    json.dump(esc, open(ESC, "w"))

if __name__ == "__main__":
    run()
