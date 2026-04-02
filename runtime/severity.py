import json

DRIFT_FILE = "drift.json"

def get_severity():
    drift = json.load(open(DRIFT_FILE)).get("count", 0)

    if drift == 0:
        return {"level": 0, "label": "STABLE"}
    elif drift == 1:
        return {"level": 1, "label": "LOW"}
    elif drift == 2:
        return {"level": 2, "label": "MEDIUM"}
    elif drift >= 3:
        return {"level": 3, "label": "CRITICAL"}

if __name__ == "__main__":
    print(get_severity())
