# swapping caps and esc using dual-function-keys (Arch - KDE with Wayland).

───────┬───────────────────────────────────────────────────────────────────────────────────────
       │ File: /etc/interception/dual-function-keys/for_vim_dfk_mappings.yaml
───────┼───────────────────────────────────────────────────────────────────────────────────────
   1   │ MAPPINGS:
   2   │   - KEY: KEY_CAPSLOCK
   3   │     TAP: KEY_ESC
   4   │     HOLD: KEY_LEFTCTRL
   5   │   - KEY: KEY_ESC
   6   │     TAP: KEY_CAPSLOCK
   7   │     HOLD: KEY_CAPSLOCK
───────┴───────────────────────────────────────────────────────────────────────────────────────

> sudo libinput list-devices | grep "^Device" # Compx Hydra 10

───────┬───────────────────────────────────────────────────────────────────────────────────────
       │ File: /etc/interception/udevmon.d/dfk_vim.yaml
───────┼───────────────────────────────────────────────────────────────────────────────────────
   1   │ - JOB: "intercept -g $DEVNODE | dual-function-keys -c /etc/interception/dual-function-
       │ keys/for_vim_dfk_mappings.yaml | uinput -d $DEVNODE"
   2   │   DEVICE:
   3   │     NAME: "Compx Hydra 10*"
───────┴───────────────────────────────────────────────────────────────────────────────────────

> sudo systemctl enable udevmon
> sudo systemctl restart udevmon
