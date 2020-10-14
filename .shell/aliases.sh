alias less='less -r'
alias top='glances'
alias pgp='gpg'

# A lot of shades of ls
# FIXME: Unreadable colors when writable by everybody
alias l='ls --color --group-directories-first'
alias ls='ls --color --group-directories-first'
alias sl='ls --color --group-directories-first'

# Useful for viewing the latest screenshot
alias tfeh='feh "$(ls -tr | tail -1)" & disown'

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

# TODO: Transferred from MacOS dots
if test "$(uname)" = 'Darwin'; then
    alias dc='docker-compose'
    alias docprune='docker system prune -a'

    alias echo='gecho'

    alias l='gls --color=auto --group-directories-first'
    alias la='gls -la --color=auto --group-directories-first'
    alias ls='gls --color=auto --hide="*.pyc" --group-directories-first'

    alias less='less -R'
    alias ln='gln'

    alias pgp='gpg'

    alias pip='pip3'
    alias python='python3'

    alias top='glances'

    alias vim='nvim'
    alias tmux='tmux -u'
fi
