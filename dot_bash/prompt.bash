function assemble_prompt {
    # Show the hostname if inside an SSH session
    local host_token
    host_token=''

    if test -n "${SSH_CLIENT}"; then
        local hostname

        # Surprisingly, not every host has hostname command installed by default
        if command -v hostname &> /dev/null; then
            hostname="$(hostname)"
        else
            hostname="$(cat /proc/sys/kernel/hostname)"
        fi

        host_token=" ${hostname} "
    fi

    # Show current git branch if the current directory is under VCS
    local git_token
    git_token=''

    local git_branch
    git_branch=$(git branch 2>/dev/null | sed -n 's/* \(.*\)/\1/p')

    if [ -n "${git_branch}" ]; then
        git_token=" ${git_branch} "
    fi

    # Show Python VirtualEnv envirnment name. This also relies on export VIRTUAL_ENV_DISABLE_PROMPT=1
    # being set in .bashrc, otherwise VirtualEnv will append its own ugly af prompt prefix as well.
    local virtualenv_token
    virtualenv_token=''

    if [ -n "${VIRTUAL_ENV}" ]; then

        # Running inside a local project environment created by Poetry
        if [[ "${VIRTUAL_ENV}" == *'.venv'* ]]; then
                virtualenv_name="$(echo "${VIRTUAL_ENV}" | rev | cut -c7- | rev | xargs basename | tr -d $'\n' | tr -d $'\r')"

        # Running inside an environment created by Pipenv or Poetry outside of the project directory
        else
                local virtualenv_name
                virtualenv_name="$(basename "${VIRTUAL_ENV}" | tr -d $'\n' | tr -d $'\r')"
                virtualenv_name="${virtualenv_name::-9}"
        fi

        virtualenv_token=" ${virtualenv_name} "
    fi

    echo -n "${host_token}${git_token}${virtualenv_token}"
}


# shellcheck disable=SC2016
printf -v PS1 "%s" '$(if [[ $? != 0 ]]; then echo " \[\e[91m\]\[\e[0m\]"; fi) \u \[\e[90m\]$(assemble_prompt)\[\e[0m\]$ '


PS2=" ↳ "

