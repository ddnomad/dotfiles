depsearch() {
    if test "$#" -ne 1; then
        echo 'Usage: depsearch DEPENDENCY_NAME'
        echo
        echo 'Output produced is relative to a base directory (default: '
        echo "$HOME/Development). Search is performed in all"
        echo 'subdirectories of a base folder (but not outside).'
        echo
        echo 'Note that only Pipfiles are scanned. Projects which use a'
        echo 'different way of specifying dependencies are not currently'
        echo 'supported.'

        return 1
    fi

    local dependency
    dependency="$1"

    local base_dir
    base_dir="${HOME}/Development"

    local fname
    find "${base_dir}" -type f -name Pipfile | while read -r fname; do
        grep -Hne "${dependency}" "${fname}" | \
            sed -ne 's@.*Development/\(.*\)@\1@p'
    done
}
