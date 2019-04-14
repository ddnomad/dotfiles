alias less='less -r'
alias top='htop'
alias pgp='gpg'

# A lot of shades of ls
# FIXME: Unreadable colors when writable by everybody
alias l='ls --color'
alias ls='ls --color'
alias sl='ls --color'

# Useful for viewing the latest screenshot
tfeh='feh "$(ls -tr | tail -1)" & disown'

# Because rsyncmasterrace
alias cp='rsync -ah --progress'
alias sucp='sudo rsync -ah --progress'

# For research purposes only
# (totally not torrenting movies)
alias mplayer='mplayer -softvol -softvol-max 1500'
alias transmission='transmission-cli'
alias peerflix='go-peerflix'
alias mixer='alsamixer'

# Do not 'cp /usr/bin/nvim /usr/bin/vim' as it will break some stuff, for
# example xxd dependencies and cause some terrible mess overall
alias vim='nvim'

# Single solution for all your pacman & AUR needs
alias pac='yay'

# Fuck people naming their tools with dashes
alias dc='docker-compose'
