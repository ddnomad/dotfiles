jqless() {
    local json_fpath
    local decompress

    if test "$#" -eq 1 && test "$1" != '-g'; then
        json_fpath="$1"
        decompress=false

    elif test "$#" -eq 2 && test "$1" = '-g'; then
        json_fpath="$2"
        decompress=true

    else
        echo 'Usage: jqless [-g] FILE'
        echo
        echo 'Pretty print input JSON file with jq and pass it to less'
        echo 'command preserving colors. If -g specified, treat a given'
        echo 'file as a gzip archive (decompress first).'

        return 1
    fi

    if ! test -f "${json_fpath}"; then
        echo "Error: No such file: ${json_fpath}"
        return 1
    fi

    if test "${decompress}" = true; then
        gzcat -d "${json_fpath}" | jq --color-output | less -R

    else
        jq --color-output < "${json_fpath}" | less -R
    fi
}
