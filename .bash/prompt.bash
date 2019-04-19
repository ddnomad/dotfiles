###############################################################################
# Assemble prompt with a git branch if current folder is a git repository
###############################################################################
function assemble_prompt {
  local git_branch
  git_branch=$(git branch 2>/dev/null | sed -n "s/* \(.*\)/\1/p")

  if [ -n "$git_branch" ]; then
    echo -e " ${git_branch} "
  fi
}

# shellcheck disable=SC2016
printf -v PS1 "%s" \
  '$(if [[ $? != 0 ]]; then echo " \[\e[91m\]\[\e[0m\]";' \
  'fi) \u \[\e[90m\]$(assemble_prompt)\[\e[0m\]$ '

# Set line continuation prompt
PS2=" ↳ "
