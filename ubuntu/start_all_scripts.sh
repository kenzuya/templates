#!/bin/bash

# Dapatkan direktori tempat skrip ini berada
SCRIPT_LOCATION="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

# Direktori tempat skrip-skrip yang akan dijalankan berada
# Diasumsikan berada di subfolder 'scripts' di lokasi skrip ini
SCRIPT_DIR="$SCRIPT_LOCATION/scripts"

# Periksa apakah direktori ada
if [ ! -d "$SCRIPT_DIR" ]; then
    echo "Error: Direktori '$SCRIPT_DIR' tidak ditemukan."
    echo "Pastikan ada subfolder 'scripts' di '$SCRIPT_LOCATION'."
    exit 1
fi

echo "Memulai semua skrip di '$SCRIPT_DIR' secara bersamaan..."

# Loop melalui setiap file di direktori
for script in "$SCRIPT_DIR"/*.sh; do
    # Periksa apakah file adalah skrip shell yang dapat dieksekusi
    if [ -f "$script" ] && [ -x "$script" ]; then
        echo "Menjalankan '$script' di latar belakang..."
        "$script" & # Jalankan skrip di latar belakang
    elif [ -f "$script" ]; then
        echo "Peringatan: '$script' bukan skrip yang dapat dieksekusi atau tidak memiliki izin eksekusi. Melewati..."
    fi
done

echo "Semua skrip telah dimulai. Skrip utama ini akan keluar sekarang."
# Skrip utama akan keluar di sini, tanpa menunggu proses anak.