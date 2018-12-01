# If not running interactively, do nothing
[[ $- != *i* ]] && return

# Load "modules"
source "$HOME"/.shell/functions.sh
source "$HOME"/.shell/aliases.sh
source "$HOME"/.bash/settings.bash
source "$HOME"/.bash/prompt.bash

# PATH additions
PATH=$HOME/scripts:$PATH
