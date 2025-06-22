#!/usr/bin/env bash
#
# dockerd.sh — Start and monitor Docker daemon on Ubuntu
#
# Usage:
#   sudo bash dockerd.sh [dockerd options ...]
#
# This script will:
#   1. Ensure it is running as root (re-executes with sudo if necessary)
#   2. (Optional) Stop any existing dockerd process to avoid conflicts
#   3. Start dockerd in foreground so the script waits until the daemon exits
#   4. Stream stdout/stderr to both the console and /var/log/dockerd.log
#
# Exit codes:
#   Mirrors dockerd's exit code so callers can react accordingly.

set -euo pipefail

# -----------------------------------------------------------------------------
# Helper functions
# -----------------------------------------------------------------------------
info()    { echo -e "\e[1;34m[INFO]\e[0m    $*"; }
success() { echo -e "\e[1;32m[SUCCESS]\e[0m $*"; }

# -----------------------------------------------------------------------------
# Ensure the script is executed with root privileges
# -----------------------------------------------------------------------------
if [[ "$(id -u)" -ne 0 ]]; then
  info "Re-executing this script with sudo to obtain root privileges..."
  exec sudo -E bash "$0" "$@"
fi

# -----------------------------------------------------------------------------
# Stop any running dockerd to avoid address/lock conflicts (optional step)
# -----------------------------------------------------------------------------
if pgrep -x dockerd >/dev/null; then
  info "Stopping existing dockerd process(es): $(pgrep -x dockerd | tr '\n' ' ')"
  pkill -TERM dockerd
  sleep 3
fi

# -----------------------------------------------------------------------------
# Start dockerd in foreground and log output
# -----------------------------------------------------------------------------
DOCKER_DATA_ROOT="/home/user/.docker_data"

# Ensure data-root directory exists with correct ownership (root) & perms
mkdir -p "$DOCKER_DATA_ROOT"
chown root:root "$DOCKER_DATA_ROOT"

# Append --data-root unless user already supplied one
EXTRA_ARGS=()
if [[ " $* " != *"--data-root"* ]]; then
  EXTRA_ARGS+=("--data-root=$DOCKER_DATA_ROOT")
fi

LOG_FILE="/var/log/dockerd.log"
info "Starting Docker daemon… Logs will be written to $LOG_FILE"

# shellcheck disable=SC2068  # we deliberately want word splitting of $@

dockerd "${EXTRA_ARGS[@]}" "$@" | tee -a "$LOG_FILE"
exit_code=$?

# -----------------------------------------------------------------------------
# Report dockerd termination status
# -----------------------------------------------------------------------------
if [[ $exit_code -eq 0 ]]; then
  success "dockerd exited normally with status $exit_code"
else
  echo -e "\e[1;31m[ERROR]\e[0m   dockerd exited with status $exit_code" >&2
fi

exit $exit_code
