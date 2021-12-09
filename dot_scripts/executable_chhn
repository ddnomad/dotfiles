#!/usr/bin/env bash
set -euo pipefail

CMD_NAME="$(basename "$0")"
readonly CMD_NAME


function main {
    if test "$#" -ne 1; then
        echo "Usage ${CMD_NAME} <hostname>"
        exit 1
    fi

    local hostname
    hostname="$1"
    readonly hostname

    echo '[>] This machine hostname will be changed'
    echo "    -> Old Hostname: $(hostname)"
    echo "    -> New Hostname: ${hostname}"

    local answer
    read -r -p '[?] Do you wish to proceed? (yes/no): ' answer
    readonly answer

    if ! test "${answer}" = 'yes'; then
        echo '[X] Cancelled on user request'
        exit 0
    fi

    echo '[i] You will be prompted to authenticate 3 times now'
    scutil --set ComputerName "${hostname}"
    scutil --set LocalHostName "${hostname}"
    scutil --set HostName "${hostname}"
    echo '[+] Hostname was changed successfully'
}

main "$@"
