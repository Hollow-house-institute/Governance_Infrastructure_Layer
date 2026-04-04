#!/data/data/com.termux/files/usr/bin/bash

ACTOR=$(whoami)
TIME=$(date -u)

echo "actor: $ACTOR | time: $TIME" >> runtime/logs/auth.log

read -p "Confirm escalation? (yes/no): " confirm

if [ "$confirm" != "yes" ]; then
  echo "Escalation aborted by human" >> runtime/logs/escalation.log
  exit 1
fi

echo "Escalation confirmed by $ACTOR at $TIME" >> runtime/logs/escalation.log
