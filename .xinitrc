# Load Xresources (rxvt terminal configuration)
test -f ~/.Xresources && xrdb -merge ~/.Xresources

# Load Xmodmap (overlay modification of keyboard layout)
test -f ~/.Xmodmap && xmodmap ~/.Xmodmap

# Start ssh-agent
eval $(ssh-agent)

# Set a desktop background
test -f ~/.fehbg && ~/.fehbg &

# Godsent utility to hide cursor when it is not used
# NOTE: Use unclutter-xfixes-git from AUR, as regular
# unclutter package breaks i3wm focusing stuff
unclutter &

# Start up a compositor to avoid nasty i3 tearing & make stuff transparent
compton -cb

# Start i3wm
exec i3
