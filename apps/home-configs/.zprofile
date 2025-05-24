#!/usr/bin/env sh

# This file runs when a DM logs you into a graphical session.
# If you use startx/xinit like a Chad, this file will also be sourced.

# Profile file. Runs on login. Environmental variables are set here.

# export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"


# Default programs:
# e
export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="google-chrome-stable"
export READER="zathura"
export FILE="ranger"
export STATUSBAR="i3blocks"

# export CHROME_EXECUTABLE="google-chrome-stable"
# export TERM=tmux-256color

# $HOME/ Clean-up:
export LESSHISTFILE="-"
export WGETRC="$HOME/.config/wget/wgetrc"
export INPUTRC="$HOME/.config/inputrc"
export ZDOTDIR="$HOME/.config/zsh"
export ZOOM_CONFIG_DIR="$HOME/.config/zoom"
# export KUBECONFIG="$HOME/.kube/config"

# export PASSWORD_STORE_DIR="$HOME/.local/share/password-store"

# Other program settings:
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"

[ ! -f $HOME/.config/shortcutrc ] && shortcuts >/dev/null 2>&1

# Switch escape and caps if tty and no passwd required:
sudo -n loadkeys $HOME/.local/share/larbs/ttymaps.kmap 2>/dev/null

PATH=$PATH:$HOME/go/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:$HOME/.local/bin/__pycache__:$HOME/.local/bin/statusbar:$HOME/.local/bin/i3cmds:$HOME/.local/bin/cron:$HOME/.local/bin/:$HOME/.config/rofi/bin:$HOME/go/go1.18.3/bin


# NODE_OPTIONS=--max-old-space-size=5000

# PATH="$PATH":"$HOME/.pub-cache/bin"

eval "$(/opt/homebrew/bin/brew shellenv)"


export K9S_CONFIG_DIR="$HOME/.config/k9s"

if [ -f "$HOME/.aws/aws-exports" ]; then
  source "$HOME/.aws/aws-exports"
fi
