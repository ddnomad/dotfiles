#!/usr/bin/env bash
set -euo pipefail

TMUX_POWERLINE_SED=gsed
if ! command -v "${TMUX_POWERLINE_SED}" &> /dev/null; then
    # shellcheck disable=SC2209
    TMUX_POWERLINE_SED=sed
fi
readonly TMUX_POWERLINE_SED

readonly TMUX_POWERLINE_DIR="${HOME}/.config/tmux/plugins/tmux-powerline"
readonly TMUX_POWERLINE_NOW_PLAYING_FILE="${TMUX_POWERLINE_DIR}/segments/now_playing.sh"
readonly TMUX_POWERLINE_SPOTIFY_MAC_FILE="${TMUX_POWERLINE_DIR}/segments/np_spotify_mac.script"
readonly TMUX_POWERLINE_WAN_IP_FILE="${TMUX_POWERLINE_DIR}/segments/wan_ip.sh"

function main {
    echo 'Patching Tmux Powerline Now Playing segment ...'
    "${TMUX_POWERLINE_SED}" \
        -i \
        's@♫@@' \
        "${TMUX_POWERLINE_NOW_PLAYING_FILE}"
    "${TMUX_POWERLINE_SED}" \
        -i \
        's@►@ @' \
        "${TMUX_POWERLINE_SPOTIFY_MAC_FILE}"
    "${TMUX_POWERLINE_SED}" \
        -i \
        's@❙❙@ @' \
        "${TMUX_POWERLINE_SPOTIFY_MAC_FILE}"

    echo 'Patching Tmux Powerline WAN IP segment ...'
    "${TMUX_POWERLINE_SED}" \
        -i \
        's@ⓦ @  @' \
        "${TMUX_POWERLINE_WAN_IP_FILE}"
}

main "$@"