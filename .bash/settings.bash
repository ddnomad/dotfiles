# Make history great again
export HISTCONTROL=ignoredups:erasedups
export HISTFILESIZE=1048576
export HISTSIZE=1048576
export SAVEHIST=$HISTSIZE
shopt -s histappend

# Stop that nano bullshit
export EDITOR=vim
export VISUAL=vim

# Fix for man-db errors
export MAN_DISABLE_SECCOMP=1
