# Force bash to load bashrc even if it is a login shell
test -f ~/.bashrc && source ~/.bashrc

# Autostart X server on tty1
if test "$(tty)" = '/dev/tty1'; then
  exec startx
fi
