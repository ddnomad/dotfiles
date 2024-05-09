#!/usr/bin/env bash
set -euo pipefail


function print {
    if test "$#" -ne 2; then
        >&2 echo 'Usage: print error|info|plain|success|warning <message>'
        return 1
    fi

    local message_type
    message_type="$1"

    local message
    message="$2"

    case "${message_type}" in
        error )
            >&2 echo "$(tput setaf 1)Error: ${message}$(tput setaf 7)"
            ;;
        info )
            >&2 echo "$(tput setaf 4)---(i) INFO: ${message}$(tput setaf 7)"
            ;;
        plain )
            >&2 echo "${message}"
            ;;
        success )
            >&2 echo "$(tput setaf 2)---(+) OK: ${message}$(tput setaf 7)"
            ;;
        warning )
            >&2 echo "$(tput setaf 3)---(!) WARNING: ${message}$(tput setaf 7)"
            ;;
        * )
            print error "Unsupported message type: ${message_type}"
            return 1
            ;;
    esac
}
