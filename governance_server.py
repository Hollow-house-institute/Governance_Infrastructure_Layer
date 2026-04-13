import os

def log_event(msg):

    try:

        os.makedirs("audits/logs", exist_ok=True)

        with open("audits/logs/events.log","a") as f:

            f.write(str(msg)+"\n")

    except:

        pass


#!/usr/bin/env python3
import time, hashlib, json, uuid
from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
from urllib.parse import parse_qs, urlparse

PORT = 8080
SESSION = {}
SESSION_TTL = 1800

def hash_pw(pw):
    return hashlib.sha256(pw.encode()).hexdigest()

import os

BASE_DIR = os.path.dirname(os.path.abspath(__file__))

with open(os.path.join(BASE_DIR, "users.json")) as f:

def create_session(user):
    sid = str(uuid.uuid4())
    SESSION[sid] = (user, time.time())
    return sid

def get_user(handler):
    query = parse_qs(urlparse(handler.path).query)
    sid = query.get("sid", [""])[0]

    if sid in SESSION:
        user, ts = SESSION[sid]
        if time.time() - ts < SESSION_TTL:
            return user

    return None

class H(SimpleHTTPRequestHandler):

    def do_GET(self):
        path = self.path.split("?")[0]
        if os.path.exists("STOP"):
            self.send_response(423)
            self.end_headers()
            self.wfile.write(b"STOP AUTHORITY ACTIVE")
            return
        path = self.path.split("?")[0]
        import subprocess
        subprocess.call(["python", "runtime/enforce.py"])
        if path == "/audits/logs/events.log":
            if not user:
                self.send_response(401); self.end_headers(); return
            try:
                with open("audits/logs/events.log","rb") as f:
                    data = f.read()[-5000:]
                self.send_response(200)
                self.send_header("Content-Type","text/plain")
                self.send_header("Content-Length", str(len(data)))
                self.end_headers()
                self.wfile.write(data)
                return
            except:
                self.send_response(404); self.end_headers(); return

        log_event("REQUEST RECEIVED")

        # --- GOVERNANCE HOOK ---
        try:
            with open("runtime/drift/drift.json") as f:
                drift = json.load(f)
                dcount = drift.get("count",0)
                level = compute_level(dcount)
                bind_escalation(dcount)
                log_event(f"DRIFT {dcount} LEVEL {level}")
        except Exception as e:
            pass

        user = get_user(self)
        path = urlparse(self.path).path
        query = urlparse(self.path).query

        if path == "/":
            if user:
                self.path = f"/governance/dashboard.html?{query}"
                return super().do_GET()

            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"""
            <html><body style="background:#0f172a;color:white;padding:40px;">
            <h2>Login</h2>
            <form method="POST" action="/login">
            <input name="username"><br><br>
            <input name="password" type="password"><br><br>
            <button>Login</button>
            </form></body></html>
            """)
            return

        if path.startswith("/governance"):
            if not user:
                self.send_response(302)
                self.send_header("Location", "/")
                self.end_headers()
                return

        if path.startswith("/runtime") or path.startswith("/audits"):
            if not user:
                self.send_response(401)
                self.end_headers()
                return

        return super().do_GET()

    def do_POST(self):
        if self.path == "/login":
            length = int(self.headers.get("Content-Length",0))
            data = self.rfile.read(length).decode()
            f = parse_qs(data)

            u = f.get("username",[""])[0]
            p = f.get("password",[""])[0]

            if u in USERS and USERS[u]["password_hash"] == hash_pw(p):
                sid = create_session(u)
                self.send_response(302)
                self.send_header("Location", f"/?sid={sid}")
                self.end_headers()
                return

            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"Invalid login")

if __name__ == "__main__":
    print("Stable server running on http://127.0.0.1:8080")
    ThreadingHTTPServer(("0.0.0.0",PORT),H).serve_forever()

# --- THRESHOLD LOGIC ---
WARNING_THRESHOLD = 1
CRITICAL_THRESHOLD = 3

def compute_level(drift_count):
    if drift_count >= CRITICAL_THRESHOLD:
        return "critical"
    if drift_count >= WARNING_THRESHOLD:
        return "warning"
    return "stable"

# --- ESCALATION BINDING ---
def write_escalation(count):
    try:
        with open("runtime/escalation/escalation.json","w") as f:
            f.write(json.dumps({"count": count}))
    except Exception:
        pass

def bind_escalation(drift_count):
    if drift_count >= CRITICAL_THRESHOLD:
        write_escalation(1)
    else:
        write_escalation(0)

# --- ROLE-BASED VIEW (header) ---
def role_header(user):
    role = USERS.get(user,{}).get("role","viewer")
    return role

# --- AUDIT LOGGING ---
def log_event(msg):
    try:
        with open("audits/logs/events.log","a") as f:
            f.write(f"{int(time.time())} {msg}\n")
    except Exception:
        pass

# --- ROLE-BASED ACCESS CONTROL ---

USER_ROLES = {
    "admin": "audit",
    "cto": "cto",
    "cfo": "cfo"
}

def get_user_role(session_id):
    user = sessions.get(session_id)
    return USER_ROLES.get(user, None)

def require_role(handler, allowed_roles):
    session_id = handler.get_cookie("session_id")
    role = get_user_role(session_id)

    if role not in allowed_roles:
        handler.send_response(403)
        handler.end_headers()
        handler.wfile.write(b"Forbidden: insufficient role")
        return False
    return True


# --- PROTECTED ROUTES EXAMPLE ---

def handle_metrics(handler):
    if not require_role(handler, ["cfo","audit","cto"]): return
    handler.serve_file("telemetry/metrics.log")

def handle_logs(handler):
    if not require_role(handler, ["cto","audit"]): return
    handler.serve_file("runtime/logs/auth.log")

def handle_escalation(handler):
    if not require_role(handler, ["audit"]): return
    handler.serve_file("runtime/escalation/escalation.json")


# --- JWT AUTH + EXPIRY + AUDIT BINDING ---
import jwt, datetime, json

SECRET_KEY = "CHANGE_THIS_SECRET"  # replace with secure value

def generate_token(user):
    payload = {
        "user": user,
        "exp": datetime.datetime.utcnow() + datetime.timedelta(hours=1)
    }
    return jwt.encode(payload, SECRET_KEY, algorithm="HS256")

def verify_token(handler):
    token = handler.headers.get("Authorization")
    if not token:
        return None
    try:
        decoded = jwt.decode(token, SECRET_KEY, algorithms=["HS256"])
        return decoded["user"]
    except jwt.ExpiredSignatureError:
        return None
    except Exception:
        return None

def audit_log(handler, user, action):
    entry = {
        "time": datetime.datetime.utcnow().isoformat(),
        "user": user,
        "action": action,
        "path": handler.path,
        "ip": handler.client_address[0]
    }
    with open("runtime/logs/audit.log", "a") as f:
        f.write(json.dumps(entry) + "\n")

def require_jwt(handler, allowed_roles, action):
    user = verify_token(handler)
    role = USER_ROLES.get(user)

    if user is None or role not in allowed_roles:
        handler.send_response(401)
        handler.end_headers()
        handler.wfile.write(b"Unauthorized")
        return None

    audit_log(handler, user, action)
    return user

# --- EXAMPLE PROTECTED ENDPOINTS ---

def handle_metrics(handler):
    if not require_jwt(handler, ["cfo","cto","audit"], "view_metrics"): return
    handler.serve_file("telemetry/metrics.log")

def handle_logs(handler):
    if not require_jwt(handler, ["cto","audit"], "view_logs"): return
    handler.serve_file("runtime/logs/auth.log")

def handle_escalation(handler):
    if not require_jwt(handler, ["audit"], "view_escalation"): return
    handler.serve_file("runtime/escalation/escalation.json")

