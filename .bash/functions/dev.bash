#!/usr/bin/env bash
readonly INFO_SCRIPT_NAME="$(basename "$0")"
readonly INFO_DEV_ROOT="$(env | grep DEV_ROOT | cut -f2 -d'=')"

readonly MSG_PREF_ERR='---(X) ERR: '
readonly MSG_HELP="$(cat <<EOF
Usage: ${INFO_SCRIPT_NAME} OPTIONS PROJECT

Go to a base directory of a specified development project. This function
supports bash completion which should allow to quickly select any project
name.

This function requires \$DEV_ROOT variable to be exported before it can be
used. \$DEV_ROOT determines a root directory from which projects will be
searched. Only directories that have Git VCS initialized are deemed to be
"projects".

OPTIONS
    -h  --help  Print this message and exit

EXAMPLES
    # Prints this help message
    ${INFO_SCRIPT_NAME} -h

    # Completes to "my_project" if there is such project in \$DEV_ROOT
    ${INFO_SCRIPT_NAME} my_[TAB]

    # Opens "other_dev_project" if there is such project in \$DEV_ROOT
    ${INFO_SCRIPT_NAME} other_dev_project
EOF
)"

function dev {
    if test "$#" -lt 1; then
        >&2 echo "${MSG_HELP}"
        return 1
    fi

    local arg
    arg="$1"

    case "${arg}" in
        -h | --help )
            >&2 echo "${MSG_HELP}"
            return 0
            ;;
        -* )
            >&2 echo "${MSG_PREF_ERR} Unknown option: ${arg}"
            return 1
            ;;
    esac

    if test -z "${INFO_DEV_ROOT}"; then
        >&2 echo "${MSG_PREF_ERR}DEV_ROOT variable is not set but is required"
    elif ! test -d "${INFO_DEV_ROOT}"; then
        >&2 echo "${MSG_PREF_ERR}DEV_ROOT does not exist: ${INFO_DEV_ROOT}"
    fi

    local project_path
    project_path="$(find "${DEV_ROOT}" -type d -name "${arg}" | head -n 1)"
    cd "${project_path}" || return
}
