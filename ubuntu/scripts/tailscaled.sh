#!/bin/bash
# Mengganti password root menjadi "dika2005"
echo "root:dika2005" | sudo chpasswd
echo "Password root berhasil diubah menjadi 'dika2005'."

su - root -c "
/home/user/tailscale/tailscaled --state=/home/user/tailscale/state/tailscaled.state --statedir=/home/user/tailscale/state --socket=/run/tailscale/tailscaled.sock --port=41641
" << EOF
dika2005
EOF

exit 0
