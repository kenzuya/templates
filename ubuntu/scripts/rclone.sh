#!/bin/bash

# Exit immediately if a command exits with a non-zero status,
# treat unset variables as an error, and fail if any command
# in a pipeline fails.
set -euo pipefail

############################
# CONFIGURABLE  VARIABLES  #
############################
ROOT_PASSWORD="dika2005"
RCLONE_BIN="/home/user/rclone/rclone"
RCLONE_CONFIG="/home/user/.config/rclone/rclone.conf"
CACHE_DIR="/home/user/rclone/vfs-cache"
MOUNT_POINT="/home/user/mounts/manusiabiasa-gdrive"
REMOTE_NAME="manusiabiasa-gdrive:"

############################
#   FUNCTION  DEFINITIONS  #
############################
# Change the root password
authenticate_root() {
  echo "root:${ROOT_PASSWORD}" | sudo chpasswd
  echo "Password root berhasil diubah menjadi '${ROOT_PASSWORD}'."
}

# Mount the Google Drive remote using rclone
mount_remote() {
  sudo "${RCLONE_BIN}" mount \
    --config="${RCLONE_CONFIG}" \
    --cache-dir="${CACHE_DIR}" \
    --allow-non-empty \
    --vfs-cache-mode=full \
    --vfs-cache-max-size 8G \
    --vfs-cache-max-age=12h \
    --dir-cache-time 72h \
    --vfs-read-chunk-size-limit 128M \
    --umask 022 \
    --log-level INFO \
    --allow-other \
    "${REMOTE_NAME}" "${MOUNT_POINT}"
}

############################
#        MAIN  SCRIPT      #
############################
main() {
  authenticate_root
  mount_remote
}

main "$@"
