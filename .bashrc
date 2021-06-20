# test
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export PATH="/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

export PATH="/home/vision/flutter setup/flutter_linux_v1.12.13+hotfix.9-stable/flutter/bin"


