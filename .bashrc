# If not running interactively, do nothing
# shellcheck disable=SC1090
[[ $- != *i* ]] && return

# Load "modules"
source ~/.bash/prompt.bash
source ~/.bash/settings.bash
source ~/.shell/aliases.sh
source ~/.shell/env.sh

# Source functions
for func in ~/.bash/functions/*; do
    # shellcheck disable=SC1090
    test -f "${func}" && source "${func}"
done

# Base16 Shell integration
# NOTE: Not exactly secure thing to use
BASE16_SHELL=~/.config/base16-shell/
test -n "$PS1" && \
  test -s "$BASE16_SHELL/profile_helper.sh" && \
  eval "$("$BASE16_SHELL/profile_helper.sh")"
