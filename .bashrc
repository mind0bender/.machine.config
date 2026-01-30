# custom alias
alias please='sudo'
# arduino-ide fix for hyprland
alias arduino-ide='arduino-ide --ozone-platform=x11'

# wrap conda in hashing enabled
set -h
# >>> conda initialize >>>
# <<< conda initialize <<<
set +h

# fuck setup
eval "$(thefuck --alias)"

# cargo setup for rust
. "$HOME/.cargo/env"

# zellij on startup
eval "$(zellij setup --generate-auto-start bash)"
