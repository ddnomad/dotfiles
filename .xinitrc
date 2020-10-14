# Load Xresources (rxvt terminal configuration)
test -f ~/.Xresources && xrdb -merge ~/.Xresources

# Load Xmodmap (overlay modification of keyboard layout)
test -f ~/.Xmodmap && xmodmap ~/.Xmodmap

# Dynamically set natural scrolling for my touchapad 
# NOTE: xmodmap approach does not work for Electron applications
# because Electron is a great way of writing desktop apps
xinput --set-int-prop 11 "libinput Natural Scrolling Enabled" 8 1

# Reduce keyboard repeat delay
#xset r rate 300 25

# Start ssh-agent
eval $(ssh-agent)

# Set a desktop background
test -f ~/.fehbg && ~/.fehbg &

# Godsent utility to hide cursor when it is not used
# NOTE: Use unclutter-xfixes-git from AUR, as regular
# unclutter package breaks i3wm focusing stuff
unclutter &

# Start up a compositor to avoid nasty i3 tearing & make stuff transparent
picom -cb

# Dynamically create a i3wm configuration based on a host type (VM or bare metal)
~/scripts/i3wm_genconfig

# Start i3wm
exec i3
