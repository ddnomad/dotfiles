# Make history great again
export HISTCONTROL=ignoredups:erasedups
export HISTFILESIZE=1048576
export HISTSIZE=1048576
export SAVEHIST=$HISTSIZE
shopt -s histappend

# Default application settings
export BROWSER=firefox
export EDITOR=vim
export VISUAL=vim

# Terminal settings for SSH/Tmux
export TERM=xterm
