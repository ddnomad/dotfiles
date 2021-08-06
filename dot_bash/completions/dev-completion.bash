#!/usr/bin/env bash

function _dev_projects_comp {
    if test -z "${DEV_ROOT}"; then
        echo "---(X) ERR: DEV_ROOT variable is not set but is required"
    elif ! test -d "${DEV_ROOT}"; then
        echo "---(X) ERR: DEV_ROOT does not exist: ${DEV_ROOT}"
    fi

    COMPREPLY=()
    local curr_word
    curr_word="${COMP_WORDS[COMP_CWORD]}"

    if ! [[ "${curr_word}" == -* ]]; then
        local projects
        projects="$(\
            find "${DEV_ROOT}" -type d -name .git -print0 |\
            xargs -0 dirname |\
            xargs -L 1 basename |\
            grep "${curr_word}" |\
            tr '\n' ' '
        )"

        mapfile -t COMPREPLY < <(compgen -W "${projects}" -- "${curr_word}")
    fi
}

complete -F _dev_projects_comp dev
