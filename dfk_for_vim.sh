#!/bin/bash
# ==============================================================================
# Dual-Function Keys Setup Script (Caps/Esc Swap for Vim)
# ------------------------------------------------------------------------------
# This script configures interception-tools and interception-dual-function-keys so that:
#   - Caps Lock → Esc when tapped, Left Ctrl when held
#   - Esc       → Caps Lock when tapped or held
#
# Works on Arch-based systems with `yay` and systemd.
#
# ==============================================================================

set -euo pipefail

CONFIG_DIR="/etc/interception"
DFK_CONFIG="$CONFIG_DIR/dual-function-keys.yaml"
UDEV_CONFIG="$CONFIG_DIR/udevmon.d/dual-function-keys.yaml"

# --- Check root ---
if [[ $EUID -ne 0 ]]; then
  echo "⚠️  Please run this script as root."
  exit 1
fi

echo "🔧 Installing required packages..."
if ! pacman -Qi interception-tools &>/dev/null || ! pacman -Qi interception-dual-function-keys &>/dev/null; then
  pacman -S --needed --noconfirm interception-tools interception-dual-function-keys
else
  echo "✅ Interception tools already installed."
fi

echo "📁 Creating configuration directories..."
mkdir -p "$CONFIG_DIR/udevmon.d"

echo "📝 Writing dual-function-keys.yaml..."
cat > "$DFK_CONFIG" <<'EOF'
MAPPINGS:
  - KEY: KEY_CAPSLOCK
    TAP: KEY_ESC
    HOLD: KEY_LEFTCTRL
  - KEY: KEY_ESC
    TAP: KEY_CAPSLOCK
    HOLD: KEY_CAPSLOCK
EOF

echo "📝 Writing udevmon config..."
cat > "$UDEV_CONFIG" <<'EOF'
- JOB: "intercept -g $DEVNODE | dual-function-keys -c /etc/interception/dual-function-keys.yaml | uinput -d $DEVNODE"
  DEVICE:
    EVENTS:
      EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
EOF

echo "🔁 Enabling and starting udevmon service..."
if ! systemctl list-unit-files | grep -q '^udevmon.service'; then
  cat > /etc/systemd/system/udevmon.service <<'EOF'
[Unit]
Description=udevmon daemon for interception-tools
After=network.target

[Service]
ExecStart=/usr/bin/udevmon -c /etc/interception/udevmon.d
Restart=always

[Install]
WantedBy=multi-user.target
EOF
  systemctl daemon-reload
fi

systemctl enable --now udevmon
systemctl restart udevmon

echo "✅ Done!"
echo
echo "🧠 Your CapsLock key now acts as:"
echo "   - Tap → Esc"
echo "   - Hold → Ctrl"
