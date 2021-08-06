# TODO: docs
# FIXME: untested
function cdp {
  readonly CUR_PWD="$(pwd)"
  while ! test -d .git; do cd ..; done
  OLDPWD="${CUR_PWD}"
}
