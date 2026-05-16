# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'
alias please='sudo'

export PATH=$PATH:/snap/bin


. "$HOME/.local/share/../bin/env"

# wrap conda in hashing enabled (else anaconda throws error)
set -h
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/mind0bender/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/mind0bender/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/mind0bender/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/mind0bender/anaconda3/bin:$PATH"
    fi
fi

unset __conda_setup
# <<< conda initialize <<<
set +h

alias arduino-ide='arduino-ide --ozone-platform=x11'
       
eval "$(thefuck --alias)"
. "$HOME/.cargo/env"

export PATH="/home/mind0bender/.cache/.bun/bin:$PATH"

alias dim='brightnessctl set 10%-'
alias bright='brightnessctl set +10%'

# <<< zellij setup >>>
# custom session picker for zellij
zj-pick() {
  if gum confirm "Attach to existing session?" --affirmative="Existing" --negative="New"; then
      local session
      session=$(zellij list-sessions -s | gum filter --placeholder "Pick a session")
      [ -n "$session" ] && zellij attach "$session"
  else
    local dir
    dir=$(gum file --directory --all)
    [ -z "$dir" ] && return
    local session_name
    session_name=$(gum input --placeholder "Enter session name...")

    zellij attach -c "$session_name" options --default-cwd "$dir"
  fi
}

# Zellij Auto-start (default)
# eval "$(zellij setup --generate-auto-start bash)"

zj-pick

# oss idea: gum time does not throuw error wnen invalid time is given, so we need to check if the input is valid before calling gum time
