#!/usr/bin/env bash
set -euo pipefail


function main {
    if test "$#" -lt 2; then
        echo "Usage: $0 \"New Show Name\" /path/to/base/dir [--dry-run]"
        exit 1
    fi

    local new_show_name="$1"
    local base_dir="$2"
    local dry_run=false

    if test "${3:-}" == "--dry-run"; then
        dry_run=true;
    fi

    if ! test -d "$base_dir"; then
        echo "Error: '$base_dir' is not a valid directory"
        exit 1
    fi

    local pattern='[sS][0-9]{2}[eE][0-9]{2}'

    find "$base_dir" -type f | while read -r filepath; do
        local filename
        filename=$(basename "$filepath")

        if [[ "$filename" =~ $pattern ]]; then
            local se_part
            se_part=$(echo "$filename" | grep -ioE "$pattern")

            local ext="${filename##*.}"

            local dir
            dir=$(dirname "$filepath")

            if [[ "$filename" == *.* ]]; then
                new_filename="${new_show_name} ${se_part}.${ext}"
            else
                new_filename="${new_show_name} ${se_part}"
            fi

            local src="$filepath"
            local dst="${dir}/${new_filename}"

            if $dry_run; then
                echo "---(i) [DRY RUN]: Would rename: '$src' -> '$dst'"
            else
                echo "---(i) INFO: Renaming: '$src' -> '$dst'"
                mv -i -- "$src" "$dst"
            fi
        fi
    done
}


main "$@"
