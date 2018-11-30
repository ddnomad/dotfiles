# Make history great again
export HISTCONTROL=ignoredups:erasedups
export HISTFILESIZE=1048576
export HISTSIZE=1048576
export SAVEHIST=$HISTSIZE
shopt -s histappend

# Stop that nano bullshit
export EDITOR=vim
export VISUAL=vim
