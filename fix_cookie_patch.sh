sed -i 's|Set-Cookie",f"{SESSION}={token}; Path=/"|Set-Cookie",f"{SESSION}={token}; Path=/; HttpOnly; SameSite=Lax"|' governance_server.py
