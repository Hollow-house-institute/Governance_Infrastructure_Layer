#!/bin/bash

ACTOR=$(whoami)
TIME=$(date -u)

echo "actor: $ACTOR | time: $TIME" >> runtime/logs/auth.log
echo "Escalation confirmed by $ACTOR at $TIME" >> runtime/logs/escalation.log
