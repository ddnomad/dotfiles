#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="$(realpath "$(dirname "${BASH_SOURCE[0]:-$0}")")"
readonly SOURCE_DIR

readonly UTILS_DIR="${SOURCE_DIR}/utils"

# shellcheck source=/dev/null
source "${UTILS_DIR}"/check_has_commands.sh
# shellcheck source=/dev/null
source "${UTILS_DIR}"/print.sh

readonly OBSIDIAN_THEMES_INDEX_URL=https://raw.githubusercontent.com/obsidianmd/obsidian-releases/master/community-css-themes.json


function install_obsidian_theme {
    if test "$#" -ne 3; then
        print plain 'Usage: install_obsidian_theme <theme_name> <dot_obsidian_directory_path> <temp_directory_path>'
        exit 1
    fi

    local theme_name
    theme_name="$1"

    local dot_obsidian_directory_path
    dot_obsidian_directory_path="$(realpath "$2")"

    local temp_dir
    temp_dir="$(realpath "$3")"

    local theme_repo
    theme_repo="$(curl -s "${OBSIDIAN_THEMES_INDEX_URL}" | jq -r ".[] | select(.name == \"${theme_name}\") | .repo")"

    if test -z "${theme_repo}"; then
        print error "Failed to find Obsidian theme by name: ${theme_name}"
        exit 1
    fi

    local release_download_url
    release_download_url="$(curl -s "https://api.github.com/repos/${theme_repo}/releases/latest" | jq -r .tarball_url)"

    if test -z "${release_download_url}"; then
        print error "Failed to retrieve Obsidian theme download URL: ${theme_name}"
        exit 1
    fi

    local release_archive_file_path
    release_archive_file_path="${temp_dir}"/release.tar.gz

    curl -s -o "${release_archive_file_path}" -L "${release_download_url}"
    tar -xf "${release_archive_file_path}" -C "${temp_dir}"

    local theme_css_file_path
    theme_css_file_path="$(ls -1 "${temp_dir}/${theme_repo/\//-}"*/theme.css)"

    local manifest_file_path
    manifest_file_path="$(ls -1 "${temp_dir}/${theme_repo/\//-}"*/manifest.json)"

    local target_theme_directory
    target_theme_directory="${dot_obsidian_directory_path}/themes/${theme_name}"

    mkdir -p "${target_theme_directory}"
    cp "${theme_css_file_path}" "${target_theme_directory}/theme.css"
    cp "${manifest_file_path}" "${target_theme_directory}/manifest.json"
}


function main {
    if test "$#" -ne 2; then
        print plain "Usage: $0 <themes_list_file_path> <dot_obsidian_directory_path>"
        exit 1
    fi

    check_has_commands curl jq mktemp

    local themes_list_file_path
    themes_list_file_path="$(realpath "$1")"

    local dot_obsidian_directory_path
    dot_obsidian_directory_path="$(realpath "$2")"

    if ! test -f "${themes_list_file_path}"; then
        print error "Provided themes list path does not exist or is not a regular file: ${themes_list_file_path}"
        exit 1
    fi

    if ! test -d "${dot_obsidian_directory_path}"; then
        print error "Provided .obsidian directory path does not exist or is not a directory: ${dot_obsidian_directory_path}"
        exit 1
    fi

    temp_dir="$(mktemp -d)"

    function delete_temp_dir {
        # shellcheck disable=SC2317
        rm -r "${temp_dir}"
    }

    trap delete_temp_dir EXIT

    local line
    local theme_name

    while read -r line; do
        if [[ "${line}" == \#* ]] || test -z "${line}"; then
            continue
        fi

        theme_name="${line}"

        print info "Installing Obsidian theme: ${theme_name}"
        install_obsidian_theme "${theme_name}" "${dot_obsidian_directory_path}" "${temp_dir}"
    done < "${themes_list_file_path}"

    print info "Setting the last encountered theme as a default one: ${theme_name}"

    temp_file_path="$(mktemp)"

    function delete_temp_file {
        # shellcheck disable=SC2317
        rm "${temp_file_path}" &> /dev/null || :
    }

    trap delete_temp_file EXIT

    local obsidian_appearance_config_file
    obsidian_appearance_config_file="${dot_obsidian_directory_path}/appearance.json"

    jq ".cssTheme = \"${theme_name}\"" "${obsidian_appearance_config_file}" > "${temp_file_path}" && \
        cp "${temp_file_path}" "${obsidian_appearance_config_file}"

    print success 'All done'
}


main "$@"
