import os, time, json

LOG="audits/logs/events.log"
STOP="STOP"

def log(actor, action):
    entry = {
        "ts": time.time(),
        "actor": actor,
        "action": action
    }
    with open(LOG, "a") as f:
        f.write(json.dumps(entry) + "\n")

def resolve(actor="admin"):
    if os.path.exists(STOP):
        os.remove(STOP)
        log(actor, "resolve_stop")

if __name__ == "__main__":
    resolve()
