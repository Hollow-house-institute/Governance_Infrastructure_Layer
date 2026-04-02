#!/data/data/com.termux/files/usr/bin/bash
set -e

PID_FILE="governance/daemon/daemon.pid"

case "$1" in
  start)
    if [ -f "$PID_FILE" ]; then
      echo "[HHI] Daemon already running."
      exit 0
    fi
    nohup bash governance/daemon/governance_daemon.sh > /dev/null 2>&1 &
    echo $! > "$PID_FILE"
    echo "[HHI] Daemon started."
    ;;
  stop)
    if [ ! -f "$PID_FILE" ]; then
      echo "[HHI] Daemon not running."
      exit 0
    fi
    kill "$(cat "$PID_FILE")"
    rm "$PID_FILE"
    echo "[HHI] Daemon stopped."
    ;;
  status)
    if [ -f "$PID_FILE" ]; then
      echo "[HHI] Daemon running (PID: $(cat "$PID_FILE"))."
    else
      echo "[HHI] Daemon not running."
    fi
    ;;
  *)
    echo "Usage: $0 {start|stop|status}"
    ;;
esac
