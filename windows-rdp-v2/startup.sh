#!/bin/bash
# Mengganti password root menjadi "dika2005"
echo "root:dika2005" | sudo chpasswd
echo "Password root berhasil diubah menjadi 'dika2005'."

# Ganti ke mode root untuk menjalankan sisa script
su - root -c "
# Change MTU Size
ifconfig eth0 mtu 1500 up
ifconfig docker0 mtu 1500 up

echo \"MTU Size telah dinaikkan menjadi 1500.\"

# Unmask docker services
systemctl unmask docker
systemctl unmask docker.socket
systemctl unmask containerd


echo \"Docker services sudah di-unmask.\"

# Start docker services
systemctl start docker
systemctl start docker.socket
systemctl start containerd
echo \"Docker services sudah dijalankan.\"

# Jalankan docker compose
docker compose up -d
echo \"Docker compose sudah dijalankan.\"
" << EOF
dika2005
EOF

exit 0
