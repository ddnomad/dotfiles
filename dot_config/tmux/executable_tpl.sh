#!/usr/bin/env bash
set -euo pipefail

TPL_SED=gsed
if ! command -v gsed &> /dev/null; then
    # shellcheck disable=SC2209
    TPL_SED=sed
fi
readonly TPL_SED

readonly TPL_DIR="${HOME}/.config/tmux/tpl"
readonly TPL_ORIGIN=https://github.com/erikw/tmux-powerline.git
# shellcheck disable=SC2016
readonly TPL_OLD_CFG='${XDG_CONFIG_HOME:-$HOME/.config}/tmux-powerline/config.sh'
# shellcheck disable=SC2016
readonly TPL_NEW_CFG='$HOME/.config/tmux/tpl.conf'
readonly TPL_PATHS_FILE="${TPL_DIR}/config/paths.sh"
readonly TPL_NOW_PLAYING_FILE="${TPL_DIR}/segments/now_playing.sh"
readonly TPL_SPOTIFY_MAC_FILE="${TPL_DIR}/segments/np_spotify_mac.script"
readonly TPL_WAN_IP_FILE="${TPL_DIR}/segments/wan_ip.sh"

function patch {
    echo 'Patching Tmux Powerline config path ...'
    "${TPL_SED}" \
        -i \
        's@^\(.*\)'"${TPL_OLD_CFG}"'\(.*\)$@\1'"${TPL_NEW_CFG}"'\2@' \
        "${TPL_PATHS_FILE}"

    echo 'Patching Tmux Powerline Now Playing segment ...'
    "${TPL_SED}" \
        -i \
        's@♫@@' \
        "${TPL_NOW_PLAYING_FILE}"
    "${TPL_SED}" \
        -i \
        's@►@ @' \
        "${TPL_SPOTIFY_MAC_FILE}"
    "${TPL_SED}" \
        -i \
        's@❙❙@ @' \
        "${TPL_SPOTIFY_MAC_FILE}"

    echo 'Patching Tmux Powerline WAN IP segment ...'
    "${TPL_SED}" \
        -i \
        's@ⓦ @  @' \
        "${TPL_WAN_IP_FILE}"
}

function init {
    if test -f "${TPL_DIR}"; then
        echo 'Error: Already initialized'
        exit 1
    fi

    echo '---(i) Initializing Tmux Powerline ...'
    git clone "${TPL_ORIGIN}" "${TPL_DIR}"

    echo '---(i) Patching Tmux Powerline ...'
    patch
}

function main {
    if test "$#" -eq 1 && test "$1" = 'init'; then
        init
        exit 0
    fi

    if ! test -d "${TPL_DIR}"; then
        echo "Error: Not initialized! Run the $0 init"
        exit 1
    fi

    "${TPL_DIR}"/powerline.sh "$@"
}

main "$@"
