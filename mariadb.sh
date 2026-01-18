#!/bin/bash
# ==============================================================================
# mariadb Setup Script
# ------------------------------------------------------------------------------
# This script installs and Initializes mariadb:
#
# Works on Arch-based systems with `yay` and systemd.
#
# ==============================================================================

set -euo pipefail

# --- Check root ---
if [[ $EUID -ne 0 ]]; then
  echo "⚠️  Please run this script as root."
  exit 1
fi

# Installing mariadb
if ! pacman -Qi mariadb &>/dev/null; then
  pacman -S --needed --noconfirm mariadb
else
  echo "✅ mariadb tools already installed."
fi

echo "📁 Initializing the data directory"
mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

echo "🔁 Starting mariadb service"
systemctl start mariadb
