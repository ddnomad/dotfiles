#!/usr/bin/env bash
set -euo pipefail


function check_has_commands {
    if test "$#" -lt 1; then
        >&2 echo 'Usage: check_has_commands <command> [<command>...]'
        return 1
    fi

    local command

    for command in "$@"; do
        if ! command -v "${command}" &> /dev/null; then
            >&2 echo "Error: Failed to detect that a command is installed: ${command}"
            return 1
        fi
    done
}
