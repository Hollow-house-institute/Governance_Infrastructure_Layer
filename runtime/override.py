import os, time, json

STOP="STOP"
LOG="audits/logs/events.log"

def override(actor, role):
    if role != "admin":
        print("Override denied")
        return

    if os.path.exists(STOP):
        os.remove(STOP)

        entry = {
            "ts": time.time(),
            "actor": actor,
            "role": role,
            "action": "override_stop"
        }

        with open(LOG, "a") as f:
            f.write(json.dumps(entry) + "\n")

        print("Override executed with accountability")

if __name__ == "__main__":
    override("admin_user", "admin")
