# Force bash to load bashrc even if it is a login shell
# shellcheck disable=SC1090
test -f ~/.bashrc && source ~/.bashrc

# Autostart X server on tty1 if not MacOS
if test "$(uname)" = 'Linux' && test "$(tty)" = '/dev/tty1'; then
  exec startx
fi
