#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="$(realpath "$(dirname "${BASH_SOURCE[0]:-$0}")")"
readonly SOURCE_DIR

readonly UTILS_DIR="${SOURCE_DIR}/utils"

# shellcheck source=/dev/null
source "${UTILS_DIR}"/check_has_commands.sh
# shellcheck source=/dev/null
source "${UTILS_DIR}"/print.sh

readonly OBSIDIAN_COMMUNITY_PLUGINS_INDEX_URL="https://raw.githubusercontent.com/obsidianmd/obsidian-releases/master/community-plugins.json"


function install_obsidian_community_plugin {
    if test "$#" -ne 3; then
        print plain 'Usage: install_obsidian_community_plugin <plugin_id> <dot_obsidian_directory_path> <temp_directory_path>'
        exit 1
    fi

    local plugin_id
    plugin_id="$1"

    local dot_obsidian_directory_path
    dot_obsidian_directory_path="$(realpath "$2")"

    local temp_dir
    temp_dir="$(realpath "$3")"

    local plugin_repo
    plugin_repo="$(curl -s "${OBSIDIAN_COMMUNITY_PLUGINS_INDEX_URL}" | jq -r ".[] | select(.id == \"${plugin_id}\") | .repo")"

    if test -z "${plugin_repo}"; then
        print error "Failed to find Obsidian community plugin by ID: ${plugin_id}"
        exit 1
    fi

    local line
    local main_download_url
    local manifest_download_url
    local styles_download_url

    main_download_url=
    manifest_download_url=
    styles_download_url=

    while IFS= read -r line; do
        local url
        url="$(cut -f2- -d':' <<<"${line}" | tr -d '"' | xargs)"

        local file_name
        file_name="$(rev <<< "${url}" | cut -d'/' -f1 | rev)"

        case "${file_name}" in
            main.js )
                main_download_url="${url}"
                ;;
            manifest.json )
                manifest_download_url="${url}"
                ;;
            styles.css )
                styles_download_url="${url}"
                ;;
            * )
                continue
                ;;
        esac
    done <<< "$(curl -s "https://api.github.com/repos/${plugin_repo}/releases/latest" | grep "browser_download_url")"

    if test -z "${main_download_url}" || test -z "${manifest_download_url}"; then
        print error "Failed to locate Obsidian community plugin download URL(s): ${plugin_id}"
        exit 1
    fi

    local main_file_path
    main_file_path="${temp_dir}/main.js"

    local manifest_file_path
    manifest_file_path="${temp_dir}/manifest.json"

    curl -s -o "${main_file_path}" -L "${main_download_url}"
    curl -s -o "${manifest_file_path}" -L "${manifest_download_url}"

    local target_plugin_directory
    target_plugin_directory="${dot_obsidian_directory_path}/plugins/${plugin_id}"

    mkdir -p "${target_plugin_directory}"
    cp "${main_file_path}" "${target_plugin_directory}/main.js"
    cp "${manifest_file_path}" "${target_plugin_directory}/manifest.json"

    if test -n "${styles_download_url}"; then
        local styles_file_path
        styles_file_path="${temp_dir}/styles.css"

        curl -s -o "${styles_file_path}" -L "${styles_download_url}"
        cp "${styles_file_path}" "${target_plugin_directory}/styles.css"
    fi

    local enabled_plugins_list_file_path
    enabled_plugins_list_file_path="${dot_obsidian_directory_path}/community-plugins.json"

    if ! test -f "${enabled_plugins_list_file_path}"; then
        echo '[]' > "${enabled_plugins_list_file_path}"
    fi

    temp_file_path="$(mktemp)"

    function delete_temp_file {
        # shellcheck disable=SC2317
        rm "${temp_file_path}" &> /dev/null || :
    }

    trap delete_temp_file EXIT

    jq ". += [\"${plugin_id}\"]" "${enabled_plugins_list_file_path}" > "${temp_file_path}" && \
        cp "${temp_file_path}" "${enabled_plugins_list_file_path}"
}


function main {
    if test "$#" -ne 2; then
        print plain "Usage: $0 <plugins_list_file_path> <dot_obsidian_directory_path>"
        exit 1
    fi

    check_has_commands curl jq mktemp

    local plugins_list_file_path
    plugins_list_file_path="$(realpath "$1")"

    local dot_obsidian_directory_path
    dot_obsidian_directory_path="$(realpath "$2")"

    if ! test -f "${plugins_list_file_path}"; then
        print error "Provided community plugins list path does not exist or is not a regular file: ${plugins_list_file_path}"
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

    local plugin_id

    while read -r plugin_id; do
        if [[ "${plugin_id}" == \#* ]] || test -z "${plugin_id}"; then
            continue
        fi

        print info "Installing Obsidian community plugin: ${plugin_id}"
        install_obsidian_community_plugin "${plugin_id}" "${dot_obsidian_directory_path}" "${temp_dir}"
    done < "${plugins_list_file_path}"

    print success 'All done'
}


main "$@"
