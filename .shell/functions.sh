# FIXME: Untested, install shellcheck first
# TODO: docs
function where {
  if test "$#" -ne 1; then
    echo '[-] Error: exactly one argument is required'
    return 1
  fi

  if [[ "$1" = -h || "$1" = --help ]]; then
    echo -e 'Usage: where <command_or_function>\n'
    echo 'Find a location of a command in PATH or a sourced function.'
    echo "If location appears as 'environment' it can't be determined"
    return 0
  fi

  local res
  if res="$(which "$@" 2> /dev/null)"; then
    echo "[+] Command ${res}"
  elif res="$(shopt -s extdebug; declare -F -- "$@")"; then
    echo -n '[+] Function '
    cut -f3 -d ' ' <<<"${res}"
  else
    echo '[-]' Error: no \'"$*"\' command or function found
    return 1
  fi
}

# TODO: docs
# FIXME: untested
function cdp {
  readonly CUR_PWD="$(pwd)"
  while ! test -d .git; do cd ..; done
  OLDPWD="${CUR_PWD}"
}
