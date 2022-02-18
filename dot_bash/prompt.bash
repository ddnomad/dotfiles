function assemble_prompt {
    local git_token
    git_token=''

    local git_branch
    git_branch=$(git branch 2>/dev/null | sed -n "s/* \(.*\)/\1/p")

    if [ -n "${git_branch}" ]; then
        git_token=" ${git_branch} "
    fi

    # Support for custom Python VirtualEnv prompt. This also relies on export VIRTUAL_ENV_DISABLE_PROMPT=1
    # being set in .bashrc, otherwise VirtualEnv will append its own ugly af prompt prefix as well.
    local virtualenv_token
    virtualenv_token=''

    if [ -n "${VIRTUAL_ENV}" ]; then
        local virtualenv_name
        virtualenv_name="$(basename "${VIRTUAL_ENV}" | tr -d $'\n' | tr -d $'\r')"
        virtualenv_token=" ${virtualenv_name::-9} "
    fi

    echo -n "${git_token}${virtualenv_token}"
}

# shellcheck disable=SC2016
printf -v PS1 "%s" \
    '$(if [[ $? != 0 ]]; then echo " \[\e[91m\]\[\e[0m\]";' \
    'fi) \u \[\e[90m\]$(assemble_prompt)\[\e[0m\]$ '

# Set line continuation prompt
PS2=" ↳ "
