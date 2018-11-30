function assemble_prompt {
  local git_branch
  git_branch=$(git branch 2>/dev/null | sed -n "s/* \(.*\)/\1/p")

  if [ -n "$git_branch" ]; then
    echo -e " ${git_branch} "
  fi
}

# Set prompts (jfc it is incomprehensible)
PS2=" ↳ "
printf -v PS1 "%s" \
  '$(if [[ $? != 0 ]]; then echo " \[\e[91m\]\[\e[0m\]";' \
  'fi) \u \[\e[90m\]$(assemble_prompt)\[\e[0m\]$ '
