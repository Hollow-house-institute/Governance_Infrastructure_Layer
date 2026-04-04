from urllib.parse import urlparse, parse_qs
import base64, hmac, hashlib

def verify_session(handler):
    try:
        query = parse_qs(urlparse(handler.path).query)
        token = query.get("s", [""])[0]
        if not token:
            return None

        v, sig = token.rsplit(".",1)
        SECRET = b"super_secret_value"

        if sig != hmac.new(SECRET, v.encode(), hashlib.sha256).hexdigest():
            return None

        user, _ = base64.urlsafe_b64decode(v + "===").decode().split(":")
        return user
    except:
        return None
