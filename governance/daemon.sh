#!/data/data/com.termux/files/usr/bin/bash

INTERVAL=60

# CONFIG (EDIT THESE)
EMAIL="you@example.com"
WEBHOOK_URL="https://hooks.slack.com/services/XXX/XXX/XXX"

echo "Governance daemon running..."

while true
do
  echo "---- cycle $(date) ----"

  ./governance/enforcement/stop_authority.sh
  STATUS=$?

  if [ $STATUS -ne 0 ]; then
    echo "STOP AUTHORITY TRIGGERED"

    mkdir -p runtime/logs
    MSG="STOP AUTHORITY TRIGGERED at $(date)"

    echo "$MSG" >> runtime/logs/stop.log

    # 📱 DEVICE ALERT
    termux-notification \
      --title "HHI Governance Alert" \
      --content "$MSG" \
      --priority high

    termux-vibrate -d 1000

    # 📧 EMAIL ALERT (requires msmtp or mail)
    echo "$MSG" | mail -s "HHI Governance Alert" "$EMAIL" 2>/dev/null

    # 🌐 WEBHOOK ALERT (Slack / API)
    curl -X POST "$WEBHOOK_URL" \
      -H "Content-Type: application/json" \
      -d "{\"text\":\"$MSG\"}" 2>/dev/null

    # 🔴 STOP SYSTEM
    pkill -f "http.server"

    exit 1
  fi

  ./audits/generate_audit_chain.sh

  sleep $INTERVAL
done
