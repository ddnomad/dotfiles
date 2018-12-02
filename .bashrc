# If not running interactively, do nothing
[[ $- != *i* ]] && return

# Load "modules"
source "$HOME"/.shell/functions.sh
source "$HOME"/.shell/aliases.sh
source "$HOME"/.bash/settings.bash
source "$HOME"/.bash/prompt.bash

# PATH additions
PATH=$HOME/scripts:$PATH

# Base16 Shell integration
# NOTE: Not exactly secure thing to use
BASE16_SHELL="$HOME/.config/base16-shell/"
test -n "$PS1" && \
  test -s "$BASE16_SHELL/profile_helper.sh" && \
  eval "$("$BASE16_SHELL/profile_helper.sh")"
