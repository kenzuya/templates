#!/usr/bin/env bash
#
# containerd.sh — Install, configure, and start containerd on Ubuntu
#
# Usage:
#   sudo bash containerd.sh
#
# This script will:
#   1. Install containerd if it is not yet present
#   2. (Optional) Stop any existing containerd process to avoid conflicts
#   3. Jalankan containerd di foreground (script menunggu hingga proses berhenti)
#   4. Simpan log ke /var/log/containerd.log dan tampilkan ke layar

set -euo pipefail

# Ensure the script is executed with root privileges; if not, re-execute using sudo
if [[ "$(id -u)" -ne 0 ]]; then
  echo "[INFO] Re-executing this script with sudo..."
  exec sudo -E bash "$0" "$@"
fi

info() { echo -e "\e[1;34m[INFO]\e[0m $*"; }
success() { echo -e "\e[1;32m[SUCCESS]\e[0m $*"; }

info "Assuming containerd is already installed. Skipping installation steps."

info "Using containerd's default internal configuration (no external config file)."

info "(Re)starting containerd in foreground mode..."

# Stop any running instance to avoid conflicts
if pgrep -x containerd >/dev/null; then
  info "Stopping existing containerd process (pid: $(pgrep -x containerd | tr '\n' ' '))"
  pkill -TERM containerd
  sleep 2
fi

LOG_FILE="/var/log/containerd.log"
info "Streaming logs to $LOG_FILE (and stdout). Press Ctrl+C to stop."

# Run containerd in foreground, tee output to log, and wait until it exits
containerd | tee -a "$LOG_FILE"

exit_code=$?

if [[ $exit_code -eq 0 ]]; then
  success "containerd exited normally with status $exit_code"
else
  echo "[ERROR] containerd exited with status $exit_code" >&2
fi

exit $exit_code
